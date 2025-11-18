Return-Path: <stable+bounces-195109-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from ams.mirrors.kernel.org (ams.mirrors.kernel.org [213.196.21.55])
	by mail.lfdr.de (Postfix) with ESMTPS id 4BC30C6A407
	for <lists+stable@lfdr.de>; Tue, 18 Nov 2025 16:13:55 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ams.mirrors.kernel.org (Postfix) with ESMTPS id E3B72383129
	for <lists+stable@lfdr.de>; Tue, 18 Nov 2025 15:12:34 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 7A436357A5D;
	Tue, 18 Nov 2025 15:12:29 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="aGT28uhb"
X-Original-To: stable@vger.kernel.org
Received: from mail-pf1-f194.google.com (mail-pf1-f194.google.com [209.85.210.194])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 507863596F9
	for <stable@vger.kernel.org>; Tue, 18 Nov 2025 15:12:27 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.210.194
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1763478749; cv=none; b=ro2kCa0ko687F2llwVYxmRxGsec83NPiWpA0tKB9qw/HIw1irUTQY+qpY0/tNy0cVGJv65rI3BjmmqXaLwd98OJykseLPCu5rlrr5I6YaoSNm/OQxGHa3WSNqW8Qt3FnSj2d5MiQBOrqR2teNlF8RcERUCXpXNKis2+ZY0vYEG0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1763478749; c=relaxed/simple;
	bh=Nhe5Vyvd7g3uc40woC2LCvlNdBNdD0TtLzwI7IjsW8I=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=rhnbWuE+EqrD1jU9HttiuJktZM6zVs/2nH7M0zAMou/i8Dy/lgcTU4hQqqY/UUjWFpUrd8sV89oKRq7Ztm81AxJC4CcJNyA7uxI20mj5R0Tmvuclt/vWNSqx1RMgHfuWeUYQgdsTfAq4NcM41UmMxdE3p5wzu2N1157HK5XiPl4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=aGT28uhb; arc=none smtp.client-ip=209.85.210.194
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-pf1-f194.google.com with SMTP id d2e1a72fcca58-7bf0ad0cb87so2544176b3a.2
        for <stable@vger.kernel.org>; Tue, 18 Nov 2025 07:12:27 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1763478746; x=1764083546; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=4U8n227WVJ+/s5DuMdAgZErEGsun6YIE7b8NKGETq30=;
        b=aGT28uhbx5qo6AW82uvbQUF0y6cD/yodOULr6hVSzRs4BzQEzonyYqSzjgr08IOYJM
         NgMoq5NskKuLT4zDgaMhUQ6Zxbmb5Ns0APzHoiENWEYX24g00QNjeshry+h3tmGzvQnm
         YY7jHF/bBgvU8ZqO54iF1drC7hqkCQfWGc9LxV7rqAVhOoQ20nwuTRdPi+YUwrGVjnEX
         a1Og7S6so9oeF1+etPemEKvuvWvsXYjEpgMGm/vH16+QFSBoHTKDzDaMdb3DSKL/tBBa
         HY8FN9T8scZLhpIJsoJd3TSv4UFXnwtsmRuECviV3CCF6d8YGSjaHzBUJi8QMuE+9Lnr
         aaGw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1763478746; x=1764083546;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=4U8n227WVJ+/s5DuMdAgZErEGsun6YIE7b8NKGETq30=;
        b=P9MF8RqgXmhhpkChN+CJt0nUH5nLL4lYnvk18clKtNbt6cTjinLyQlw9BF3p3ym6tS
         ZDUpCrg2MHL2dAS+kJtbybFgfQAGCBqXWW2g6mxtH4Ns0HpZAfsG1G7P1m5kJ5P09vrz
         oyUX0/W/BwFIHf8G9rTtQ6CwQ9M413/W+ET3lcsrJ97ZDp6Y+c1exEOlRW/Nl/sMyv8j
         hJ/Pa3txYklN17E+owRZbsR8vo5nSua5/66zu51k5mGjaZR9jtHTbBJuPAD2DpkA3iee
         ET88Vm1hTT8jP4Y+mqVk1XbQUTqFhzFmfwdF95lTMSJUV4uf12CqYtNfMFFZPUCcgVC6
         7a7g==
X-Gm-Message-State: AOJu0YxRCvWWTH16Upja4foFbA3DZXbBraF0Yxz0/L/2e7lbGmtn/wfN
	5uGgO+ysiWGE2ex4Wjr8cFM7NjxXghb3lWYWLrgqXNXTownllWvJJxdBd+1OC6O0mw6b5w==
X-Gm-Gg: ASbGncuEamxcgtCc2grtDS6mNRMmSuCPTu7WfXrKgugF6W5Ia474rfhrTJ9vd/Sk4yZ
	2A8kT8K0zsaY3l24P9oePx7io+DghOaMW0SR4j5SpjZg4n+EOJT+NeVNhgjP/6+RHKNPv+I882B
	4Z5GMDGvd+Hzi08ALIy8UsNbHF8iCB/c7aHHtMS6VPsJg6S704D/5d/8AHRl0fH88VvQEyu5g3y
	GK/uSIiPAA7RKo26CIclI65+omPt8Z/ZS1RpWk2lZr+sb8SwxEN0MlpUhEw9RdNu4sez5fWLRNO
	8i+6x/Ek0/2k2Jv9GbRDfawu19GDIji9l8RFhwpttBzCfAmUd7yG1chsadgDxr2tqzr6mMEpaKF
	ptarq/lVd9UqIbxRx24/ifqsMAtu1idA/T0uBPEQR3PtmNu1+sDjQ23q4A+0ViHLrgw74dlIjbK
	fVz8btqx/PzbuPjbYLVboo8l7fSygFMfdU8rFN+I25+w==
X-Google-Smtp-Source: AGHT+IEujV1fUJ8lZnQHc6gH+zbAny7hB+uRThe/ABbVHlvWbOoSDuT1svWqm9T3c6BG1veFPuF1wQ==
X-Received: by 2002:a05:6a20:939f:b0:34e:eb6a:c765 with SMTP id adf61e73a8af0-35ba1c8bc80mr20038159637.37.1763478745965;
        Tue, 18 Nov 2025 07:12:25 -0800 (PST)
Received: from DESKTOP-Q6PJO4M.localdomain ([221.228.238.82])
        by smtp.gmail.com with ESMTPSA id d2e1a72fcca58-7ba438bed8csm14148847b3a.53.2025.11.18.07.12.23
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 18 Nov 2025 07:12:25 -0800 (PST)
From: Slavin Liu <slavin452@gmail.com>
To: stable@vger.kernel.org
Cc: Slavin Liu <slavin452@gmail.com>,
	Sabrina Dubroca <sd@queasysnail.net>,
	Steffen Klassert <steffen.klassert@secunet.com>,
	"netdev@vger.kernel.org" <netdev@vger.kernel.org>
Subject: [BUG] Missing backport for commit b441cf3f8c4b ("xfrm: delete x->tunnel as we delete x")
Date: Tue, 18 Nov 2025 23:11:40 +0800
Message-ID: <20251118151140.89427-1-slavin452@gmail.com>
X-Mailer: git-send-email 2.43.0
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

Hi,

I would like to request backporting commit b441cf3f8c4b ("xfrm: delete 
x->tunnel as we delete x") to all LTS kernels.
This patch actually fixes a use-after-free issue, but it hasn't been 
backported to any of the LTS versions, which are still being affected. 

As the patch describes, a specific trigger scenario could be:

If a tunnel packet is received (e.g., in ip_local_deliver()), with the 
outer layer being IPComp protocol and the inner layer being fragmented 
packets, during outer packet processing, it will go through xfrm_input() 
to hold a reference to the IPComp xfrm_state. Then, it is re-injected into 
the network stack via gro_cells_receive() and placed in the reassembly 
queue. When exiting the netns and calling cleanup_net(), although 
ipv4_frags_exit_net() is called before xfrm_net_exit(), due to asynchronous 
scheduling, fqdir_free_work() may execute after xfrm_state_fini().

In xfrm_state_fini(), xfrm_state_flush() puts and deletes the xfrm_state 
for IPPROTO_COMP, but does not delete the xfrm_state for IPPROTO_IPIP. 
Meanwhile, the skb in the reassembly queue holds the last reference to the 
IPPROTO_COMP xfrm_state, so it isn't destroyed yet. Only when the skb in 
the reassembly queue is destroyed does the IPPROTO_COMP xfrm_state get 
fully destroyed, which calls ipcomp_destroy() to delete the IPPROTO_IPIP 
xfrm_state. However, by this time, the hash tables (net->xfrm.state_byxxx) 
have already been kfreed in xfrm_state_fini(), leading to a use-after-free 
during the deletion.

The bug has existed since kernel v2.6.29, so the patch should be 
backported to all LTS kernels.

thanks,

Slavin Liu

