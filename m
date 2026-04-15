Return-Path: <stable+bounces-238070-lists+stable=lfdr.de@vger.kernel.org>
Delivered-To: lists+stable@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id oJdeMpRW32n1RwAAu9opvQ
	(envelope-from <stable+bounces-238070-lists+stable=lfdr.de@vger.kernel.org>)
	for <lists+stable@lfdr.de>; Wed, 15 Apr 2026 11:12:52 +0200
X-Original-To: lists+stable@lfdr.de
Received: from sto.lore.kernel.org (sto.lore.kernel.org [IPv6:2600:3c09:e001:a7::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id D135D402642
	for <lists+stable@lfdr.de>; Wed, 15 Apr 2026 11:12:51 +0200 (CEST)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sto.lore.kernel.org (Postfix) with ESMTP id 1C481302C49E
	for <lists+stable@lfdr.de>; Wed, 15 Apr 2026 09:12:51 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 8CC233254B2;
	Wed, 15 Apr 2026 09:12:48 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=139.com header.i=@139.com header.b="MRMYJrbP"
X-Original-To: stable@vger.kernel.org
Received: from n169-110.mail.139.com (n169-110.mail.139.com [120.232.169.110])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4F3913246F4
	for <stable@vger.kernel.org>; Wed, 15 Apr 2026 09:12:43 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=120.232.169.110
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1776244368; cv=none; b=jnCGl8q78swaiEUOxa5Qhgh450BPuRslU3J2K0kvXCzOputvP8QeCwgBQodlK827imwRfRFgUhyYp9Qm07N9tEBUrfhURKUiMbaa9adj3oIEeunYZwVgRhYqSsoChi33eqfHPIdm8+FWQYjwr/ssyl2DufC7O0eGN0bjd51K03I=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1776244368; c=relaxed/simple;
	bh=NMFAZfnlwobC/iyaWjuMwHYpf8zMFwmpuo/W2HSnq5M=;
	h=From:To:Subject:Date:Message-Id:MIME-Version:Content-Type; b=KW8RS82QXekSqjDageH//oTULv3H7CsPd8CNpay5DW5a0z90jgrq1BfJr1t+og796lXyhLdh2j10wiBVbqwRLclx78nvos6P15OkAXCFlfYna2aLGnmJo4k2cgyj6O3XAaaz4lUdw5eehTTNDo3QizbgCHR3TkybKDcnN+G1ez0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=139.com; spf=pass smtp.mailfrom=139.com; dkim=pass (1024-bit key) header.d=139.com header.i=@139.com header.b=MRMYJrbP; arc=none smtp.client-ip=120.232.169.110
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=139.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=139.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
	d=139.com; s=dkim; l=0;
	h=from:subject:message-id:to:mime-version;
	bh=47DEQpj8HBSa+/TImW+5JCeuQeRkm5NMpJWZG3hSuFU=;
	b=MRMYJrbP3ksDnafsNfJwpJFEBKnQ2gb0gTgBVr2T8AF2vLo7b4okP9vigb9wz//4bE5MhKeGbkDqD
	 Zf7/9bKJk5OV/YuWVDFH81G85nfGLUqiBcZ0o/2hu+g4ODlkg64V+ds9yue0YsVOccvIAl7hFt6fB9
	 01pAwMudznpvUBAc=
X-RM-TagInfo: emlType=0                                       
X-RM-SPAM:                                                                                        
X-RM-SPAM-FLAG:00000000
Received:from NTT-kernel-dev (unknown[223.104.41.126])
	by rmsmtp-lg-appmail-09-12087 (RichMail) with SMTP id 2f3769df5680d70-028a7;
	Wed, 15 Apr 2026 17:12:35 +0800 (CST)
X-RM-TRANSID:2f3769df5680d70-028a7
From: Rajani Kantha <681739313@139.com>
To: liuhangbin@gmail.com,
	razor@blackwall.org,
	toke@redhat.com,
	kuba@kernel.org,
	wangliang74@huawei.com,
	joamaki@gmail.com,
	stable@vger.kernel.org
Subject: [PATCH 6.1.y 0/2] Backport 2 commits to 6.1.y to fix bond issue
Date: Wed, 15 Apr 2026 17:12:30 +0800
Message-Id: <20260415091232.3244-1-681739313@139.com>
X-Mailer: git-send-email 2.35.3
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-Spamd-Result: default: False [0.54 / 15.00];
	MID_CONTAINS_FROM(1.00)[];
	R_DKIM_REJECT(1.00)[139.com:s=dkim];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	R_SPF_ALLOW(-0.20)[+ip6:2600:3c09:e001:a7::/64:c];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	TAGGED_FROM(0.00)[bounces-238070-lists,stable=lfdr.de];
	RCVD_TLS_LAST(0.00)[];
	RCVD_COUNT_THREE(0.00)[4];
	FREEMAIL_TO(0.00)[gmail.com,blackwall.org,redhat.com,kernel.org,huawei.com,vger.kernel.org];
	DMARC_NA(0.00)[139.com];
	MIME_TRACE(0.00)[0:+];
	FORGED_SENDER_MAILLIST(0.00)[];
	FROM_HAS_DN(0.00)[];
	ASN(0.00)[asn:63949, ipnet:2600:3c09::/32, country:SG];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	TO_DN_NONE(0.00)[];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[681739313@139.com,stable@vger.kernel.org];
	DKIM_TRACE(0.00)[139.com:-];
	NEURAL_HAM(-0.00)[-0.915];
	TAGGED_RCPT(0.00)[stable];
	RCPT_COUNT_SEVEN(0.00)[7];
	FREEMAIL_FROM(0.00)[139.com];
	DBL_BLOCKED_OPENRESOLVER(0.00)[sto.lore.kernel.org:helo,sto.lore.kernel.org:rdns,139.com:mid]
X-Rspamd-Queue-Id: D135D402642
X-Rspamd-Action: no action
X-Rspamd-Server: lfdr

Backport commit: 094ee6017ea0 ("bonding: check xdp prog when set bond
mode") to 6.1.y to fix a bond issue.

It depends on commit: 22ccb684c1ca ("bonding: return detailed
error when loading native XDP fails)

In order to make a clean backport on stable kernel, backport 2 commits.


Hangbin Liu (1):
  bonding: return detailed error when loading native XDP fails

Wang Liang (1):
  bonding: check xdp prog when set bond mode

 drivers/net/bonding/bond_main.c    | 9 ++++++---
 drivers/net/bonding/bond_options.c | 3 +++
 include/net/bonding.h              | 1 +
 3 files changed, 10 insertions(+), 3 deletions(-)

-- 
2.35.3



