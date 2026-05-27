Return-Path: <stable+bounces-254565-lists+stable=lfdr.de@vger.kernel.org>
Delivered-To: lists+stable@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id 6A8DFDfeFmo9uQcAu9opvQ
	(envelope-from <stable+bounces-254565-lists+stable=lfdr.de@vger.kernel.org>)
	for <lists+stable@lfdr.de>; Wed, 27 May 2026 14:06:15 +0200
X-Original-To: lists+stable@lfdr.de
Received: from sto.lore.kernel.org (sto.lore.kernel.org [IPv6:2600:3c09:e001:a7::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id E42925E3D13
	for <lists+stable@lfdr.de>; Wed, 27 May 2026 14:06:14 +0200 (CEST)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sto.lore.kernel.org (Postfix) with ESMTP id 1F9AD301D01F
	for <lists+stable@lfdr.de>; Wed, 27 May 2026 12:06:08 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 4F658302742;
	Wed, 27 May 2026 12:06:05 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="oK8AU559"
X-Original-To: stable@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E988C13C918;
	Wed, 27 May 2026 12:06:03 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1779883565; cv=none; b=jZnmnJVRtbJs9wU7WNxpEwChuuT3InF4LbieVRzIDmlKrmgcTttPhKshwwxvrSRi4XHpILOOmRJ99B/UxU1SC0Cb9RPb1UKfCh7IAh3zghuW1C5ZLRxEJpe63dbu7Ydc3DzZGnURsrYHSl2ApD+/Zisqv9GnSYYPxN/wcsFHDGg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1779883565; c=relaxed/simple;
	bh=5W01sVx2RIds1DAOkxhzGj9ZtpdsFUHRR8oVnYx2nJs=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=t4hwWvIzb+PfC5BdeW8woKoLG1V/fDuoqYlG7oIburF2yIpyLv7+cJuLWcUng0KDW66pF6dvTmC3AohS+uPT917XYcKj+P1ErY3n2V4Pn9/AMVA1g9rZhSdVDNZucHfaeLvX/JB3wZY4eZQfD5Orf71UJgcHGt/jEu3FkeITFx0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=oK8AU559; arc=none smtp.client-ip=100.103.45.18
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 06A891F000E9;
	Wed, 27 May 2026 12:06:02 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1779883563;
	bh=dYvl/3K29ZV0cu6YhcZ12nwDPuy1zRO0Zwwz9harlvI=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References;
	b=oK8AU559BaLR2fPxyVi7243iqoyERX+Ugey2BDdJscf12Vqg5eAn/pA48SUXxIAsn
	 QmkQGsfDddmcxtKNxK8vmRnIDruyd8OC/0DEiaTSyRnijOyxk1qNW2JYCqQ3MjESFA
	 ZcalzM9xWVxYuQHnbj3rxhjenPkPSv2Rx6GNqI153k8n5js+3bFdtP8ezEkhv2wGkK
	 lTGeRKB1QENiQPpB/aNSRoIQiZ2VL061rDm3DZ27OSRJ8kfpjBqEqlgAfql3SLIw59
	 Pw7PyyPDXZa57Buw13sguImfvo7/uRAJIkbJiCdhi8QF5N8VStxarQV6BTK1dOS2j0
	 ldVux0BuBeXGw==
Received: from phl-compute-05.internal (phl-compute-05.internal [10.202.2.45])
	by mailfauth.phl.internal (Postfix) with ESMTP id 660ADF40092;
	Wed, 27 May 2026 08:06:02 -0400 (EDT)
Received: from phl-frontend-03 ([10.202.2.162])
  by phl-compute-05.internal (MEProxy); Wed, 27 May 2026 08:06:02 -0400
X-ME-Sender: <xms:Kt4WaoeIz6s4NUz7gMqJi0bme15P5Z3JVl-bePxYjh8BdpTYL4qT_Q>
    <xme:Kt4WarLpssZjuct2fgUJzworyl_EIOkzz6gZK85_sI_ih0yZkYYcUr7WpkDN6Psc5
    4yZf3Litq3UWADjwKWB14HvuxMxAX2ETQmI6RNwZx8SjcEdUN9yV7c>
X-ME-Received: <xmr:Kt4Wap1y6AJU29sDunwnLM6NAUojlBcMrIe9jFek7RIf9QzB4Cwzmx8PE5YgdA>
X-ME-Proxy-Cause: dmFkZTGqAdtnwb61wYan5C4OJsoWLkQNYl2+q5bhbZ8696FiUgmZzm685bBBUbynyEgwk9
    LCDvc8MDP6PRosY/0LosT3Qdb0dk7uwQzgHaQellK3fcQWXXqX07suu6SzIMUDibK4jWkW
    iOAnXeDPHCbZrTopbRqvNqcS8TJoPKroKLjoTh0vQcgBEa67F2kTYv2fZUhOC9BS3QxCde
    qrmrfeOswU9Av2XVPIeZlRLWQ/r8fxk5RD4wN5ziq7iwXH+fBtu+wn+B2xVy9yCrzPuhAm
    W46wVvBf0oF9Jh2+ecSuLnfJtZOU6eoHRXFan8ENohXk0lRn/Dg/NXlu0lNK26nvI9MPie
    ibQh815KzENS6fVWW0CZSI2U190QERIn3/cVZlQsx4AaHT8h4L9yc+AyCkvpwgQvXy8gf4
    482xb2HXFScobWwq5W0/Mj/ggSwRq2cDC/Uf9oPOIQZHCMJGRvLLRRksZKihaNuC/ZfvoT
    VmlNgr6Cm9pv/QJWW8Y/AkQVxb2EQcT3Loc8FHnpo3+b3/JNLSwtnj0SXEU+A4Etk2nUSy
    CkIC+zgQmlRLVR3KmNXXUAn4IA7LxqVtky20UrTvE6zt5gE77mHbuZPeX9jr8JmPXA9QeV
    VjdZyF3NOR2wda9SmRIqbk8QEZOxFqK3TFd+I/TJjD/hip9ekvvjhYP4HPMg
X-ME-Proxy: <xmx:Kt4WasakL5CyyK9Zhdf2C7lXaWCgdMd9VfAnaqSbDlaHhzx0ZIyo_Q>
    <xmx:Kt4Wariu0IaJzO5abvbn2YG5WMQDUAeXBR2doVJxAfnB7eavgZm1ZQ>
    <xmx:Kt4Waj9zuM4aGXjLh9SoXmzYsj5e_mRMNFJXG_hsA1atERaJdKoHbw>
    <xmx:Kt4WahNICV9HrW_2qYbUiaHjXDbVJO_E0xycYRW3v15nZjO_XjuUfg>
    <xmx:Kt4Wauqa3tuQeO3FfoHNGKYOrSBPBa-Hzsz_nqjpHbIm6IsgNfsdC5e_>
Feedback-ID: i10464835:Fastmail
Received: by mail.messagingengine.com (Postfix) with ESMTPA; Wed,
 27 May 2026 08:06:00 -0400 (EDT)
From: "Kiryl Shutsemau (Meta)" <kas@kernel.org>
To: Thomas Gleixner <tglx@kernel.org>,
	Ingo Molnar <mingo@redhat.com>,
	Borislav Petkov <bp@alien8.de>,
	Dave Hansen <dave.hansen@linux.intel.com>,
	x86@kernel.org
Cc: "H . Peter Anvin" <hpa@zytor.com>,
	Rick Edgecombe <rick.p.edgecombe@intel.com>,
	Kuppuswamy Sathyanarayanan <sathyanarayanan.kuppuswamy@linux.intel.com>,
	Kai Huang <kai.huang@intel.com>,
	Sean Christopherson <seanjc@google.com>,
	Borys Tsyrulnikov <tsyrulnikov.borys@gmail.com>,
	linux-kernel@vger.kernel.org,
	linux-coco@lists.linux.dev,
	kvm@vger.kernel.org,
	stable@vger.kernel.org,
	"Kiryl Shutsemau (Meta)" <kas@kernel.org>
Subject: [PATCH v3 1/2] x86/tdx: Fix off-by-one in port I/O handling
Date: Wed, 27 May 2026 13:05:43 +0100
Message-ID: <20260527120544.2903923-2-kas@kernel.org>
X-Mailer: git-send-email 2.54.0
In-Reply-To: <20260527120544.2903923-1-kas@kernel.org>
References: <20260527120544.2903923-1-kas@kernel.org>
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spamd-Result: default: False [0.84 / 15.00];
	SUSPICIOUS_RECIPS(1.50)[];
	MID_CONTAINS_FROM(1.00)[];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	R_MISSING_CHARSET(0.50)[];
	DMARC_POLICY_ALLOW(-0.50)[kernel.org,quarantine];
	R_SPF_ALLOW(-0.20)[+ip6:2600:3c09:e001:a7::/64:c];
	R_DKIM_ALLOW(-0.20)[kernel.org:s=k20260515];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	FREEMAIL_CC(0.00)[zytor.com,intel.com,linux.intel.com,google.com,gmail.com,vger.kernel.org,lists.linux.dev,kernel.org];
	RCPT_COUNT_TWELVE(0.00)[16];
	MIME_TRACE(0.00)[0:+];
	TAGGED_FROM(0.00)[bounces-254565-lists,stable=lfdr.de];
	FORGED_SENDER_MAILLIST(0.00)[];
	RCVD_TLS_LAST(0.00)[];
	ASN(0.00)[asn:63949, ipnet:2600:3c09::/32, country:SG];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[kas@kernel.org,stable@vger.kernel.org];
	FROM_HAS_DN(0.00)[];
	DKIM_TRACE(0.00)[kernel.org:+];
	DBL_BLOCKED_OPENRESOLVER(0.00)[intel.com:email,sto.lore.kernel.org:rdns,sto.lore.kernel.org:helo];
	TAGGED_RCPT(0.00)[stable];
	NEURAL_HAM(-0.00)[-0.999];
	TO_DN_SOME(0.00)[];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	RCVD_COUNT_SEVEN(0.00)[7]
X-Rspamd-Queue-Id: E42925E3D13
X-Rspamd-Action: no action
X-Rspamd-Server: lfdr

handle_in() and handle_out() in arch/x86/coco/tdx/tdx.c use:

    u64 mask = GENMASK(BITS_PER_BYTE * size, 0);

GENMASK(h, l) includes bit h. For size=1 (INB), this produces
GENMASK(8, 0) = 0x1FF (9 bits) instead of GENMASK(7, 0) = 0xFF (8
bits). The mask is one bit too wide for all I/O sizes.

Fix the mask calculation.

Fixes: 03149948832a ("x86/tdx: Port I/O: Add runtime hypercalls")
Reported-by: Borys Tsyrulnikov <tsyrulnikov.borys@gmail.com>
Link: https://lore.kernel.org/all/CAKw_Dz96rfSQc6Rn+9QBcUFHhmkK+9zu+P=bxowfZwxrATCBRg@mail.gmail.com/
Signed-off-by: Kiryl Shutsemau (Meta) <kas@kernel.org>
Reviewed-by: Kai Huang <kai.huang@intel.com>
Reviewed-by: Kuppuswamy Sathyanarayanan <sathyanarayanan.kuppuswamy@linux.intel.com>
Cc: stable@vger.kernel.org
---
 arch/x86/coco/tdx/tdx.c | 4 ++--
 1 file changed, 2 insertions(+), 2 deletions(-)

diff --git a/arch/x86/coco/tdx/tdx.c b/arch/x86/coco/tdx/tdx.c
index 186915a17c50..65119362f9a2 100644
--- a/arch/x86/coco/tdx/tdx.c
+++ b/arch/x86/coco/tdx/tdx.c
@@ -693,7 +693,7 @@ static bool handle_in(struct pt_regs *regs, int size, int port)
 		.r13 = PORT_READ,
 		.r14 = port,
 	};
-	u64 mask = GENMASK(BITS_PER_BYTE * size, 0);
+	u64 mask = GENMASK(BITS_PER_BYTE * size - 1, 0);
 	bool success;
 
 	/*
@@ -713,7 +713,7 @@ static bool handle_in(struct pt_regs *regs, int size, int port)
 
 static bool handle_out(struct pt_regs *regs, int size, int port)
 {
-	u64 mask = GENMASK(BITS_PER_BYTE * size, 0);
+	u64 mask = GENMASK(BITS_PER_BYTE * size - 1, 0);
 
 	/*
 	 * Emulate the I/O write via hypercall. More info about ABI can be found
-- 
2.54.0


