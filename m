Return-Path: <stable+bounces-241818-lists+stable=lfdr.de@vger.kernel.org>
Delivered-To: lists+stable@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id 4Nd5NxeU8WlxiQEAu9opvQ
	(envelope-from <stable+bounces-241818-lists+stable=lfdr.de@vger.kernel.org>)
	for <lists+stable@lfdr.de>; Wed, 29 Apr 2026 07:16:07 +0200
X-Original-To: lists+stable@lfdr.de
Received: from tor.lore.kernel.org (tor.lore.kernel.org [IPv6:2600:3c04:e001:36c::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id 503EE48F63A
	for <lists+stable@lfdr.de>; Wed, 29 Apr 2026 07:16:06 +0200 (CEST)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by tor.lore.kernel.org (Postfix) with ESMTP id 943443039C63
	for <lists+stable@lfdr.de>; Wed, 29 Apr 2026 05:14:34 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 075163890F7;
	Wed, 29 Apr 2026 05:14:29 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="F9tVPs3q"
X-Original-To: stable@vger.kernel.org
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.129.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 759023502A7
	for <stable@vger.kernel.org>; Wed, 29 Apr 2026 05:14:27 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.129.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1777439668; cv=none; b=JCKut8M9pCJQkI7CpcIxOa/cEAs/SVR+3eBUvuMhJV8YFL06E+bVRRQhyBG3GEftmDXcCiMI9JjAJPRsB7WW+bpTOk/V03hqMDs7L01H0Ty1bUBsbzjAOHfbRQCW7xMZbGXkRjudTkiypDuKkpnkw5V7R05z8ohfLBCReSiJnwk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1777439668; c=relaxed/simple;
	bh=isNmRuNuMJx4i8ElKaXr/14tWumKpXs9Ca+p5ETyqY4=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=cs800wSRUweoaxUPfdgr6t1f/uVhQTiTHTKTjCKIaNE5UOe6RYk9rpfC+j71IyxGREmmxV8u2j5SCuE6Jc28vAQG87cjd5q5N1mqzMZTHugUbc5Cj8DePq8m3aiPdUTDtLdQ/HDQ3XBU2SAQhdv7Da5HfR+fociYF8UZagFEmNE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=F9tVPs3q; arc=none smtp.client-ip=170.10.129.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1777439666;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=isNmRuNuMJx4i8ElKaXr/14tWumKpXs9Ca+p5ETyqY4=;
	b=F9tVPs3q9DpF9p4sMGbsnCc7wG02ncwkf1xybXyqEQYrUZOI1LrHIHaRn7xeZyjDpQDaUv
	PCFPunootiJkAq32RibJO5T6wz0fV6NS6IG5RcG99S8YublA2c9h9vB+VBTEq6+LT7l0UO
	dG4NBTxV48I+QrhQ2xBwP1mcd8DpzlE=
Received: from mx-prod-mc-01.mail-002.prod.us-west-2.aws.redhat.com
 (ec2-54-186-198-63.us-west-2.compute.amazonaws.com [54.186.198.63]) by
 relay.mimecast.com with ESMTP with STARTTLS (version=TLSv1.3,
 cipher=TLS_AES_256_GCM_SHA384) id us-mta-587-olkNOLz3PZysue0b_2x2Eg-1; Wed,
 29 Apr 2026 01:14:22 -0400
X-MC-Unique: olkNOLz3PZysue0b_2x2Eg-1
X-Mimecast-MFC-AGG-ID: olkNOLz3PZysue0b_2x2Eg_1777439661
Received: from mx-prod-int-01.mail-002.prod.us-west-2.aws.redhat.com (mx-prod-int-01.mail-002.prod.us-west-2.aws.redhat.com [10.30.177.4])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by mx-prod-mc-01.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTPS id C3D4D195608B;
	Wed, 29 Apr 2026 05:14:20 +0000 (UTC)
Received: from fedora.redhat.com (unknown [10.44.32.45])
	by mx-prod-int-01.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTP id 0E77C300756E;
	Wed, 29 Apr 2026 05:14:15 +0000 (UTC)
From: Jose Ignacio Tornos Martinez <jtornosm@redhat.com>
To: baochen.qiang@oss.qualcomm.com
Cc: ath11k@lists.infradead.org,
	jjohnson@kernel.org,
	jtornosm@redhat.com,
	linux-kernel@vger.kernel.org,
	linux-wireless@vger.kernel.org,
	stable@vger.kernel.org
Subject: Re: [PATCH] wifi: ath11k: fix warning when unbinding
Date: Wed, 29 Apr 2026 07:14:03 +0200
Message-ID: <20260429051414.6625-1-jtornosm@redhat.com>
In-Reply-To: <c0d2b6df-4109-4c93-b229-7eb2d3fca6a7@oss.qualcomm.com>
References: <c0d2b6df-4109-4c93-b229-7eb2d3fca6a7@oss.qualcomm.com>
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-Scanned-By: MIMEDefang 3.4.1 on 10.30.177.4
X-Rspamd-Queue-Id: 503EE48F63A
X-Rspamd-Action: no action
X-Rspamd-Server: lfdr
X-Spamd-Result: default: False [-1.16 / 15.00];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	MID_CONTAINS_FROM(1.00)[];
	DMARC_POLICY_ALLOW(-0.50)[redhat.com,quarantine];
	R_DKIM_ALLOW(-0.20)[redhat.com:s=mimecast20190719];
	R_SPF_ALLOW(-0.20)[+ip6:2600:3c04:e001:36c::/64:c];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	FORGED_SENDER_MAILLIST(0.00)[];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	DKIM_TRACE(0.00)[redhat.com:+];
	TAGGED_FROM(0.00)[bounces-241818-lists,stable=lfdr.de];
	RCVD_TLS_LAST(0.00)[];
	MISSING_XM_UA(0.00)[];
	FROM_HAS_DN(0.00)[];
	MIME_TRACE(0.00)[0:+];
	RCVD_COUNT_FIVE(0.00)[6];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[jtornosm@redhat.com,stable@vger.kernel.org];
	ASN(0.00)[asn:63949, ipnet:2600:3c04::/32, country:SG];
	TO_DN_NONE(0.00)[];
	RCPT_COUNT_SEVEN(0.00)[7];
	NEURAL_HAM(-0.00)[-1.000];
	TAGGED_RCPT(0.00)[stable];
	DBL_BLOCKED_OPENRESOLVER(0.00)[tor.lore.kernel.org:helo,tor.lore.kernel.org:rdns]

Hello Baochen,

As I try to comment in the commit description, the warning is not at
the intialization, but comes up when the device is unbinded after a
problem at the initialization stage, because due to the problem the
buffers were released (probe). Later after the problem, if the unbinding
is commanded the buffers are released again.
Setting to NUll after releasing avoids the double free.

The easiest way to reproduce it is to run in a VM the default upstream
kernel (that is always failing on VMs) and just unbind the device
(ath11k_pci).

The same problem was fixed by me for ath12k driver here ca68ce0d9f4b
("wifi: ath12k: fix warning when unbinding"), and I have seen the same problem
is also happening for ath11k driver.

Thanks

Best regards
José Ignacio


