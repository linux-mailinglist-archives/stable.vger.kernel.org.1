Return-Path: <stable+bounces-254122-lists+stable=lfdr.de@vger.kernel.org>
Delivered-To: lists+stable@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id MHxaFygjFGq3KAcAu9opvQ
	(envelope-from <stable+bounces-254122-lists+stable=lfdr.de@vger.kernel.org>)
	for <lists+stable@lfdr.de>; Mon, 25 May 2026 12:23:36 +0200
X-Original-To: lists+stable@lfdr.de
Received: from sin.lore.kernel.org (sin.lore.kernel.org [104.64.211.4])
	by mail.lfdr.de (Postfix) with ESMTPS id 62D9A5C9380
	for <lists+stable@lfdr.de>; Mon, 25 May 2026 12:23:34 +0200 (CEST)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sin.lore.kernel.org (Postfix) with ESMTP id E09D23004604
	for <lists+stable@lfdr.de>; Mon, 25 May 2026 10:23:31 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 1AD6C34CFD6;
	Mon, 25 May 2026 10:23:28 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=alpinelinux.org header.i=@alpinelinux.org header.b="QL/LeKdV"
X-Original-To: stable@vger.kernel.org
Received: from gbr-app-1.alpinelinux.org (gbr-app-1.alpinelinux.org [213.219.36.190])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 86D5533BBC0;
	Mon, 25 May 2026 10:23:26 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=213.219.36.190
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1779704607; cv=none; b=KYLbaN/VWCct8ZX1F5v22Yzc0fgCI9cu9L2rmLYJg7touZcila84UPycT5rSnCS8VF0Z/0HRaSV373cj90WHK/fEhrw3xRcpCIb/l2EEPStln3vLxajNyEMJDdmbh9nYDn1ahKpYG2IfYc7Bns3Lz1/VBxGdOCGlYPZSoZQA/+Q=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1779704607; c=relaxed/simple;
	bh=wWKjwz/Nf7HobhIbhjS79dG16zIEtgDlDfCdkXFB/ac=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=fyo5y4Y/3qeI8YegU8RCrc21AldTIk9ixCu5N+sIZj4MIHBzcrQ82MGdCoQAHjY2N7bQgZ7hKgyZlUH6rsZU/mpWoSFLU8oA/pHAzXALxLIaT4tcjMudJiS6qSsj1PyMdlaVjOsGIYjBqsBxIy1c1pAq6bSL3Pqq6QKdLj+/PNo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=alpinelinux.org; spf=pass smtp.mailfrom=alpinelinux.org; dkim=pass (1024-bit key) header.d=alpinelinux.org header.i=@alpinelinux.org header.b=QL/LeKdV; arc=none smtp.client-ip=213.219.36.190
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=alpinelinux.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=alpinelinux.org
Received: from ncopa-desktop.lan (unknown [IPv6:2001:4646:fb05:0:d699:1ea6:9121:5917])
	(Authenticated sender: ncopa@alpinelinux.org)
	by gbr-app-1.alpinelinux.org (Postfix) with ESMTPSA id 2C8BD21FFF4;
	Mon, 25 May 2026 10:16:46 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=alpinelinux.org;
	s=smtp; t=1779704207;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:
	 content-transfer-encoding:content-transfer-encoding;
	bh=++VeZLzQoCtGMr/Pi4krdEDJj/34GslrOlv08fSwzwY=;
	b=QL/LeKdVzxH4dm7fTa0xb7T/WLZLRysDvhFsRJwjftwxonq7aKAz5PLMi5pBVF0YRTZuIg
	6O6ThI5eEuUV6hVqcK4uLxndhCTZMAnwyu72wdr+MvA+BjHxMkxQahBN+fpvhFS1WG79Nx
	vNzHyD0f2Osis+1UCQuoAf9aIiUZoGU=
From: Natanael Copa <ncopa@alpinelinux.org>
To: stable@vger.kernel.org
Cc: regressions@lists.linux.dev,
	linux-s390@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	vneethv@linux.ibm.com,
	oberpar@linux.ibm.com,
	hca@linux.ibm.com,
	gor@linux.ibm.com,
	agordeev@linux.ibm.com,
	borntraeger@linux.ibm.com,
	svens@linux.ibm.com
Subject: [REGRESSION] 6.6.141 s390x build failure in s390/cio due to missing driver_override infrastructure
Date: Mon, 25 May 2026 12:16:34 +0200
Message-ID: <20260525101635.26090-1-ncopa@alpinelinux.org>
X-Mailer: git-send-email 2.54.0
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spamd-Result: default: False [-0.16 / 15.00];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	MID_CONTAINS_FROM(1.00)[];
	R_MISSING_CHARSET(0.50)[];
	R_SPF_ALLOW(-0.20)[+ip4:104.64.211.4:c];
	R_DKIM_ALLOW(-0.20)[alpinelinux.org:s=smtp];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	RCVD_TLS_LAST(0.00)[];
	TAGGED_FROM(0.00)[bounces-254122-lists,stable=lfdr.de];
	TO_DN_NONE(0.00)[];
	RCVD_COUNT_THREE(0.00)[4];
	DMARC_NA(0.00)[alpinelinux.org];
	FROM_NEQ_ENVFROM(0.00)[ncopa@alpinelinux.org,stable@vger.kernel.org];
	FORGED_SENDER_MAILLIST(0.00)[];
	DKIM_TRACE(0.00)[alpinelinux.org:+];
	ASN(0.00)[asn:63949, ipnet:104.64.192.0/19, country:SG];
	PRECEDENCE_BULK(0.00)[];
	RCPT_COUNT_SEVEN(0.00)[11];
	NEURAL_HAM(-0.00)[-1.000];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	TAGGED_RCPT(0.00)[stable];
	MIME_TRACE(0.00)[0:+];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	FROM_HAS_DN(0.00)[]
X-Rspamd-Queue-Id: 62D9A5C9380
X-Rspamd-Action: no action
X-Rspamd-Server: lfdr

This reports a regression in the 6.6.y stable series.

Last known good: v6.6.140
First bad: v6.6.141

On s390x, v6.6.141 fails to build in drivers/s390/cio/css.c after the
backport of:

  ac4d8bb6e2e13e8684a76ea48d13ebaaaf5c24c4 ("s390/cio: use generic driver_override infrastructure")

which is present in 6.6.141 as:

  c4295487124f ("s390/cio: use generic driver_override infrastructure")

The failure is:

  drivers/s390/cio/css.c:1329:15: error: implicit declaration of function 'device_match_driver_override' [-Werror=implicit-function-declaration]
  drivers/s390/cio/css.c:1387:10: error: 'struct bus_type' has no member named 'driver_override'

This backport appears to depend on newer driver-core infrastructure that
is not present in 6.6.y, in particular:

  cb3d1049f4ea ("driver core: generalize driver_override in struct device")
  stable backport: da332e7ecbb3

In other words, the s390/cio conversion was backported without the
driver-core support it requires.

I verified the source tree version with:

  make -s kernelversion
  => 6.6.141

A minimal fix for 6.6.y seems to be reverting ac4d8bb6e2e13e8684a76ea48d13ebaaaf5c24c4.
An alternative would be a small s390/cio-specific locking fix that avoids
depending on the newer driver-core APIs.

#regzbot introduced: v6.6.140..v6.6.141
#regzbot title: s390x build failure in 6.6.141 due to incomplete s390/cio driver_override backport

