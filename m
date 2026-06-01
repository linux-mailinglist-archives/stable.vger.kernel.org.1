Return-Path: <stable+bounces-259449-lists+stable=lfdr.de@vger.kernel.org>
Delivered-To: lists+stable@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id +MV4AEglHWq6VwkAu9opvQ
	(envelope-from <stable+bounces-259449-lists+stable=lfdr.de@vger.kernel.org>)
	for <lists+stable@lfdr.de>; Mon, 01 Jun 2026 08:23:04 +0200
X-Original-To: lists+stable@lfdr.de
Received: from tor.lore.kernel.org (tor.lore.kernel.org [172.105.105.114])
	by mail.lfdr.de (Postfix) with ESMTPS id 96FCF61A1F8
	for <lists+stable@lfdr.de>; Mon, 01 Jun 2026 08:23:03 +0200 (CEST)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by tor.lore.kernel.org (Postfix) with ESMTP id 224E430759E6
	for <lists+stable@lfdr.de>; Mon,  1 Jun 2026 06:17:17 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 8417B346A0B;
	Mon,  1 Jun 2026 06:16:15 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=139.com header.i=@139.com header.b="u9U0p3kf"
X-Original-To: stable@vger.kernel.org
Received: from n169-113.mail.139.com (n169-113.mail.139.com [120.232.169.113])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0221935837E
	for <stable@vger.kernel.org>; Mon,  1 Jun 2026 06:16:10 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=120.232.169.113
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1780294575; cv=none; b=a2x3JSP9TFTGAFJs23idVQofNFu/6mHIeAeHQsxoVJDZxHAR3BC/insrzp5zf5bemS9QyIMxZSWOEIWEcO1boVoBSoFs5w9C/07ovSgxM7nv94Lo+uMH43Jd/cQjppNW+mICd5N41JUrltQlFUbHlf+W+TrdUPJYLE1J0DYPXA8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1780294575; c=relaxed/simple;
	bh=MfqazXi3ZQBE/Md0XT4zztcwG2a3V+UANbg9N7mlhpg=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=Y+82lceFu/s8oKJPiI/Dk5b5ZQI/2Fcva56ChontIH/YfWddpCG2T+14F9ixnw2Dpb88VkNltONbjBI5u8yiNwUC7cPdv9RO9QiXjwFpv2xtS1+IShK6hhGuoGsT9u/d6jvT8eLlmiAar3XiC4sLYOhRJuOYx5o8BHfyfNs03Qo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=139.com; spf=pass smtp.mailfrom=139.com; dkim=pass (1024-bit key) header.d=139.com header.i=@139.com header.b=u9U0p3kf; arc=none smtp.client-ip=120.232.169.113
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=139.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=139.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
	d=139.com; s=dkim; l=0;
	h=from:subject:message-id:to:cc:mime-version;
	bh=47DEQpj8HBSa+/TImW+5JCeuQeRkm5NMpJWZG3hSuFU=;
	b=u9U0p3kfOL3ca2QWa2zV9EN8iAKNCuVk809VxoXR0LkxKYwZB8HwWbJL7leR3NK4O125UjurPtxxd
	 e8KoMELr7x+AufDWUo85wF/YeeEMwMUMMKq4Ye/gdY3XkOxQwuwJKRxWRkxaUzTW6/uz0IxVEcItLO
	 ItTzC1ZjVqcrO94U=
X-RM-TagInfo: emlType=0                                       
X-RM-SPAM:                                                                                        
X-RM-SPAM-FLAG:00000000
Received:from NTT-kernel-dev (unknown[60.247.85.88])
	by rmsmtp-lg-appmail-34-12048 (RichMail) with SMTP id 2f106a1d239a5cd-06643;
	Mon, 01 Jun 2026 14:15:59 +0800 (CST)
X-RM-TRANSID:2f106a1d239a5cd-06643
From: Li hongliang <1468888505@139.com>
To: sashal@kernel.org
Cc: kuba@kernel.org,
	patzilla007@gmail.com,
	stable@vger.kernel.org,
	willemb@google.com
Subject: Re: [PATCH 6.1.y] net/packet: fix TOCTOU race on mmap'd vnet_hdr in tpacket_snd()
Date: Mon,  1 Jun 2026 14:15:58 +0800
Message-Id: <20260601061558.3703791-1-1468888505@139.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20260425095519.3477961-1-sashal@kernel.org>
References: <20260425095519.3477961-1-sashal@kernel.org>
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable
X-Spamd-Result: default: False [1.04 / 15.00];
	MID_CONTAINS_FROM(1.00)[];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	R_DKIM_REJECT(1.00)[139.com:s=dkim];
	R_MISSING_CHARSET(0.50)[];
	R_SPF_ALLOW(-0.20)[+ip4:172.105.105.114:c];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	TAGGED_FROM(0.00)[bounces-259449-lists,stable=lfdr.de];
	FREEMAIL_FROM(0.00)[139.com];
	FREEMAIL_CC(0.00)[kernel.org,gmail.com,vger.kernel.org,google.com];
	RCVD_TLS_LAST(0.00)[];
	DMARC_NA(0.00)[139.com];
	FORGED_SENDER_MAILLIST(0.00)[];
	MIME_TRACE(0.00)[0:+];
	RCVD_COUNT_THREE(0.00)[4];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	RCPT_COUNT_FIVE(0.00)[5];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[1468888505@139.com,stable@vger.kernel.org];
	FROM_HAS_DN(0.00)[];
	DKIM_TRACE(0.00)[139.com:-];
	TO_DN_NONE(0.00)[];
	TAGGED_RCPT(0.00)[stable];
	NEURAL_HAM(-0.00)[-0.122];
	ASN(0.00)[asn:63949, ipnet:172.105.96.0/20, country:SG];
	DBL_BLOCKED_OPENRESOLVER(0.00)[tor.lore.kernel.org:rdns,tor.lore.kernel.org:helo]
X-Rspamd-Queue-Id: 96FCF61A1F8
X-Rspamd-Action: no action
X-Rspamd-Server: lfdr

Hello,=0D
I am interested in this patch and was wondering why it hasn't been accepted=
 upstream. Is there a specific reason for that?=


