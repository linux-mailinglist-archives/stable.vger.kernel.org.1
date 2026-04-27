Return-Path: <stable+bounces-241278-lists+stable=lfdr.de@vger.kernel.org>
Delivered-To: lists+stable@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id uNGDOLAr72mb8wAAu9opvQ
	(envelope-from <stable+bounces-241278-lists+stable=lfdr.de@vger.kernel.org>)
	for <lists+stable@lfdr.de>; Mon, 27 Apr 2026 11:26:08 +0200
X-Original-To: lists+stable@lfdr.de
Received: from sto.lore.kernel.org (sto.lore.kernel.org [172.232.135.74])
	by mail.lfdr.de (Postfix) with ESMTPS id 0A70F46FE3B
	for <lists+stable@lfdr.de>; Mon, 27 Apr 2026 11:26:07 +0200 (CEST)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sto.lore.kernel.org (Postfix) with ESMTP id 588193004627
	for <lists+stable@lfdr.de>; Mon, 27 Apr 2026 09:26:07 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 02FC83B27C3;
	Mon, 27 Apr 2026 09:26:06 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=139.com header.i=@139.com header.b="KAHlnEv6"
X-Original-To: stable@vger.kernel.org
Received: from n169-110.mail.139.com (n169-110.mail.139.com [120.232.169.110])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id E8C0839A04F
	for <stable@vger.kernel.org>; Mon, 27 Apr 2026 09:26:00 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=120.232.169.110
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1777281965; cv=none; b=GQf6Nel6AxlGVS0Pn1rnjx7ItY7fiP5hOs9penfzmXBoKHkBlSx+V7MBt3NRaLslZ8gjbfOUdXgsZl/A10ApaeLBqYsWFfuvIZBvVW9GVjKHb+LhsECnebBTvGAoCsW2921GnePZFY+p5Qkh31CbTFAyN8Y2HLj9E5eDIeQeMpA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1777281965; c=relaxed/simple;
	bh=3rtYksr0qDDm6mvjjqGt7yx3Igdmkv26BiZCxq9Gh+s=;
	h=From:To:Subject:Date:Message-Id:MIME-Version; b=LwSizw8guLpEVNHkWlwE82U+vad/Kac9gvZ3bjc3p1iCNinCE1M0zqGGoLmpkkVN2lq4KYgrTW6AkxKimv4QzuOm+yJbkgmq+CVtDBMfRo5IX6ClmIFx3gOZaBa2vQ/q+jXP9gKvnK6L8/IsAyS7ZNUsI11ZHAy19ribhyUKp5I=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=139.com; spf=pass smtp.mailfrom=139.com; dkim=pass (1024-bit key) header.d=139.com header.i=@139.com header.b=KAHlnEv6; arc=none smtp.client-ip=120.232.169.110
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=139.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=139.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
	d=139.com; s=dkim; l=0;
	h=from:subject:message-id:to:mime-version;
	bh=47DEQpj8HBSa+/TImW+5JCeuQeRkm5NMpJWZG3hSuFU=;
	b=KAHlnEv62iXlhapqBw2WPnOgwbvnq/18NDCkWwqwJFC3qvPMPR+W6Gu+pHWT4joznrtv/dx8Dbknr
	 0sNeVGxYYEDN2Y/bZZdjG6Qz/weTWMn2ZgUcEzSAlHlL0p4b033vs44SG/Nleo3WXUPMfzsFSEyDKj
	 eHj72wcVBzW1WlBM=
X-RM-TagInfo: emlType=0                                       
X-RM-SPAM:                                                                                        
X-RM-SPAM-FLAG:00000000
Received:from China-Mobile-Kernel-Team (unknown[223.104.40.155])
	by rmsmtp-lg-appmail-01-12079 (RichMail) with SMTP id 2f2f69ef2ae88d8-783c3;
	Mon, 27 Apr 2026 17:22:50 +0800 (CST)
X-RM-TRANSID:2f2f69ef2ae88d8-783c3
From: Leon Chen <leonchen.oss@139.com>
To: youngmin.nam@samsung.com,
	hy50.seo@samsung.com,
	mark.rutland@arm.com,
	catalin.marinas@arm.com,
	gregkh@linuxfoundation.org,
	stable@vger.kernel.org
Subject: [PATCH 6.1.y 0/1] Backport commit:f6794950f0e5 to 6.1.y
Date: Mon, 27 Apr 2026 17:22:47 +0800
Message-Id: <20260427092248.10853-1-leonchen.oss@139.com>
X-Mailer: git-send-email 2.35.3
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Rspamd-Queue-Id: 0A70F46FE3B
X-Rspamd-Action: no action
X-Rspamd-Server: lfdr
X-Spamd-Result: default: False [1.04 / 15.00];
	MID_CONTAINS_FROM(1.00)[];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	R_DKIM_REJECT(1.00)[139.com:s=dkim];
	R_MISSING_CHARSET(0.50)[];
	R_SPF_ALLOW(-0.20)[+ip4:172.232.135.74:c];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	TAGGED_FROM(0.00)[bounces-241278-lists,stable=lfdr.de];
	FREEMAIL_FROM(0.00)[139.com];
	RCVD_TLS_LAST(0.00)[];
	DMARC_NA(0.00)[139.com];
	FORGED_SENDER_MAILLIST(0.00)[];
	MIME_TRACE(0.00)[0:+];
	RCVD_COUNT_THREE(0.00)[4];
	ASN(0.00)[asn:63949, ipnet:172.232.128.0/19, country:SG];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[leonchen.oss@139.com,stable@vger.kernel.org];
	FROM_HAS_DN(0.00)[];
	DKIM_TRACE(0.00)[139.com:-];
	TO_DN_NONE(0.00)[];
	TAGGED_RCPT(0.00)[stable];
	NEURAL_HAM(-0.00)[-0.114];
	RCPT_COUNT_FIVE(0.00)[6];
	DBL_BLOCKED_OPENRESOLVER(0.00)[sto.lore.kernel.org:helo,sto.lore.kernel.org:rdns]

Hi Greg,

The commit:f6794950f0e5("arm64: set __exception_irq_entry with __irq_entry as a default")
is available on linux 5.15.y (commit-5.15:0bd309f22663), but missing on
6.1.y.

The patch try to backport it to 6.1.y as well.

Youngmin Nam (1):
  arm64: set __exception_irq_entry with __irq_entry as a default

 arch/arm64/include/asm/exception.h | 5 -----
 1 file changed, 5 deletions(-)

-- 
2.35.3



