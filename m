Return-Path: <stable+bounces-231403-lists+stable=lfdr.de@vger.kernel.org>
Delivered-To: lists+stable@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id SNVqMXiwy2kpKAYAu9opvQ
	(envelope-from <stable+bounces-231403-lists+stable=lfdr.de@vger.kernel.org>)
	for <lists+stable@lfdr.de>; Tue, 31 Mar 2026 13:31:04 +0200
X-Original-To: lists+stable@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [172.234.253.10])
	by mail.lfdr.de (Postfix) with ESMTPS id 31CAE368CAF
	for <lists+stable@lfdr.de>; Tue, 31 Mar 2026 13:31:04 +0200 (CEST)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id 1E657311A3B1
	for <lists+stable@lfdr.de>; Tue, 31 Mar 2026 11:24:45 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 686A23D9034;
	Tue, 31 Mar 2026 11:24:40 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="lWKMLdxx"
X-Original-To: stable@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0B5B63D34AD;
	Tue, 31 Mar 2026 11:24:39 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1774956280; cv=none; b=jHV5LG+Iq3CqEjjwOMDAKAf26hn2sErCf5idKuZn+iRBTiClWeaQauoOLFLozgsUD4accY/r71hD1OUVbk4vsC1VzkPPluYySrBtBe7z6gNrIzvzvxur7fOzdHr6QvB/ElYiGGwopPaS9dtxD1Tn3gbV0pVEzGsKlXYdTJHFR4k=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1774956280; c=relaxed/simple;
	bh=G+HXWzbrzqhC4JhX7Pf60aGMXBlK3busY8Njcqfv5ds=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=aED2+JjTxIpW8mTA0CZrO6AK4uT0HiE4wPEvYNBwqyronxDF7qKuCxi0D7yo3ylyMW8NjeAHKYJLXQKK0cLQ3mgTNE4vLGcRmmvZ1/o+qdVl11dadFi4pS/lwIQl+VE37G8kjOojiu/8T/Q5P/KlBX9g3M9Hs9+KFRKuUKg3f64=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=lWKMLdxx; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 625C6C2BCB9;
	Tue, 31 Mar 2026 11:24:39 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1774956279;
	bh=G+HXWzbrzqhC4JhX7Pf60aGMXBlK3busY8Njcqfv5ds=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=lWKMLdxx+WNEUvE4fmQ7IKeNyutGNlR4VXq4lIGLJDn9lBAvLsQpV9glUSt6g3FQe
	 vsrWNe1Io1RhS2Pwl6NSeRzVj53EMelpYt4VALBJXiPrbc3sE09qEl8OnFR9NhU93f
	 Sv1Y43Xy3HMN9zsj3kl3awo9mgY8vuw80YeSZEoHkLRipzi5X/2nti1B/wDDrtWCvp
	 GQ/KFoo7SziXtzK2W1aKfYZ6sxW5xecyp4CAopeENYtznoHtibTUYhSl/anTu4zxe7
	 3ehJ1+1JMQU5USFnmrRw5B7tqhTINeAlcE4ZACW3Eo/ZxXcmU+AE3l4+4hNWCVprYD
	 GsyG3WxeYVX+Q==
Received: from phl-compute-01.internal (phl-compute-01.internal [10.202.2.41])
	by mailfauth.phl.internal (Postfix) with ESMTP id 93635F40068;
	Tue, 31 Mar 2026 07:24:38 -0400 (EDT)
Received: from phl-frontend-04 ([10.202.2.163])
  by phl-compute-01.internal (MEProxy); Tue, 31 Mar 2026 07:24:38 -0400
X-ME-Sender: <xms:9q7LaegPa3KHAwzxv2Q90UbPDxxJgNCwp4_6cFC4kIo5_Q4nCOOCag>
    <xme:9q7LaedZJ92hGKW-xwUDJlwqA03eWrKJANuDJWszJ6meTCK0HJAVxjWxDPjnc9T0u
    M4_onQaSgMNfYQT26dJsP0tpQRCA37le6IM2_wIaN8ruxiNZaRB6js>
X-ME-Received: <xmr:9q7LaXLWpUu1qqn5RC-W5I--LtFT8vO35tTGH7OvPfq8CZPvbwbT3OPKTe1LYw>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgeefhedrtddtgddtjecutefuodetggdotefrodftvf
    curfhrohhfihhlvgemucfhrghsthforghilhdpuffrtefokffrpgfnqfghnecuuegrihhl
    ohhuthemuceftddtnecusecvtfgvtghiphhivghnthhsucdlqddutddtmdenucfjughrpe
    fhvfevufffkffojghfggfgsedtkeertdertddtnecuhfhrohhmpedfmfhirhihlhcuufhh
    uhhtshgvmhgruhculdfovghtrgdmfdcuoehkrghssehkvghrnhgvlhdrohhrgheqnecugg
    ftrfgrthhtvghrnhephfdujeefvdegkefffedvkeehkeekueevfedtleehgeetlefgfeev
    veeukefhtdetnecuvehluhhsthgvrhfuihiivgeptdenucfrrghrrghmpehmrghilhhfrh
    homhepkhhirhhilhhlodhmvghsmhhtphgruhhthhhpvghrshhonhgrlhhithihqdduiedu
    udeivdeiheehqddvkeeggeegjedvkedqkhgrsheppehkvghrnhgvlhdrohhrghesshhhuh
    htvghmohhvrdhnrghmvgdpnhgspghrtghpthhtohepudegpdhmohguvgepshhmthhpohhu
    thdprhgtphhtthhopehtghhlgieskhgvrhhnvghlrdhorhhgpdhrtghpthhtohepmhhinh
    hgohesrhgvughhrghtrdgtohhmpdhrtghpthhtohepsghpsegrlhhivghnkedruggvpdhr
    tghpthhtohepuggrvhgvrdhhrghnshgvnheslhhinhhugidrihhnthgvlhdrtghomhdprh
    gtphhtthhopeigkeeisehkvghrnhgvlhdrohhrghdprhgtphhtthhopehkrghssehkvghr
    nhgvlhdrohhrghdprhgtphhtthhopehhphgrseiihihtohhrrdgtohhmpdhrtghpthhtoh
    eprhhitghkrdhprdgvughgvggtohhmsggvsehinhhtvghlrdgtohhmpdhrtghpthhtohep
    shgrthhhhigrnhgrrhgrhigrnhgrnhdrkhhuphhpuhhsfigrmhihsehlihhnuhigrdhinh
    htvghlrdgtohhm
X-ME-Proxy: <xmx:9q7LabktCfVZ1VeBunq3fhpztZF3VJLbu_Z44ir1EbeBVKa25TkOXA>
    <xmx:9q7LafcdbIkG8NpvQXpV1Sfz3a0X4ui5zWFJNzvry0nL-iIqKSQkMA>
    <xmx:9q7Lacx7Os7aF8PHs-Wj9ixihSjPAPdM0hp_byxzbtqxYF0sZubJKQ>
    <xmx:9q7LaYII23ypaGHpDE3SyVkMBD1uYTQZxXGJqbd8TJZ-tyHR-UtjLQ>
    <xmx:9q7LadvKcjpkN1T2a4Rr9JCtJ19A7WCSiCzh4Ml8BhcSzy0Pyt3-zvbW>
Feedback-ID: i10464835:Fastmail
Received: by mail.messagingengine.com (Postfix) with ESMTPA; Tue,
 31 Mar 2026 07:24:38 -0400 (EDT)
From: "Kiryl Shutsemau (Meta)" <kas@kernel.org>
To: Thomas Gleixner <tglx@kernel.org>,
	Ingo Molnar <mingo@redhat.com>,
	Borislav Petkov <bp@alien8.de>,
	Dave Hansen <dave.hansen@linux.intel.com>,
	x86@kernel.org
Cc: Kiryl Shutsemau <kas@kernel.org>,
	"H . Peter Anvin" <hpa@zytor.com>,
	Rick Edgecombe <rick.p.edgecombe@intel.com>,
	Kuppuswamy Sathyanarayanan <sathyanarayanan.kuppuswamy@linux.intel.com>,
	Borys Tsyrulnikov <tsyrulnikov.borys@gmail.com>,
	linux-kernel@vger.kernel.org,
	linux-coco@lists.linux.dev,
	kvm@vger.kernel.org,
	stable@vger.kernel.org
Subject: [PATCH 2/2] x86/tdx: Fix zero-extension for 32-bit port I/O
Date: Tue, 31 Mar 2026 12:24:30 +0100
Message-ID: <20260331112430.71425-3-kas@kernel.org>
X-Mailer: git-send-email 2.51.2
In-Reply-To: <20260331112430.71425-1-kas@kernel.org>
References: <20260331112430.71425-1-kas@kernel.org>
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
	R_SPF_ALLOW(-0.20)[+ip4:172.234.253.10:c];
	R_DKIM_ALLOW(-0.20)[kernel.org:s=k20201202];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	FREEMAIL_CC(0.00)[kernel.org,zytor.com,intel.com,linux.intel.com,gmail.com,vger.kernel.org,lists.linux.dev];
	RCPT_COUNT_TWELVE(0.00)[14];
	MIME_TRACE(0.00)[0:+];
	TAGGED_FROM(0.00)[bounces-231403-lists,stable=lfdr.de];
	FORGED_SENDER_MAILLIST(0.00)[];
	RCVD_TLS_LAST(0.00)[];
	ASN(0.00)[asn:63949, ipnet:172.234.224.0/19, country:SG];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[kas@kernel.org,stable@vger.kernel.org];
	FROM_HAS_DN(0.00)[];
	DKIM_TRACE(0.00)[kernel.org:+];
	DBL_BLOCKED_OPENRESOLVER(0.00)[sea.lore.kernel.org:helo,sea.lore.kernel.org:rdns];
	TAGGED_RCPT(0.00)[stable];
	NEURAL_HAM(-0.00)[-1.000];
	TO_DN_SOME(0.00)[];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	RCVD_COUNT_SEVEN(0.00)[7]
X-Rspamd-Queue-Id: 31CAE368CAF
X-Rspamd-Action: no action
X-Rspamd-Server: lfdr

According to x86 architecture rules, 32-bit operations zero-extend the
result to 64 bits. The current implementation of handle_in() only masks
the lower 32 bits, which preserves the upper 32 bits of RAX when a
32-bit port IN instruction is emulated.

Update handle_in() to zero out the entire RAX register when the I/O size
is 4 bytes to ensure correct zero-extension. For smaller sizes (1 or 2
bytes), continue to preserve the unaffected upper bits.

Fixes: 03149948832a ("x86/tdx: Port I/O: Add runtime hypercalls")
Reported-by: Borys Tsyrulnikov <tsyrulnikov.borys@gmail.com>
Signed-off-by: Kiryl Shutsemau (Meta) <kas@kernel.org>
Cc: stable@vger.kernel.org
---
 arch/x86/coco/tdx/tdx.c | 13 +++++++++++--
 1 file changed, 11 insertions(+), 2 deletions(-)

diff --git a/arch/x86/coco/tdx/tdx.c b/arch/x86/coco/tdx/tdx.c
index 4d7f71d50122..b9b9a2d75119 100644
--- a/arch/x86/coco/tdx/tdx.c
+++ b/arch/x86/coco/tdx/tdx.c
@@ -703,8 +703,17 @@ static bool handle_in(struct pt_regs *regs, int size, int port)
 	 */
 	success = !__tdx_hypercall(&args);
 
-	/* Update part of the register affected by the emulated instruction */
-	regs->ax &= ~mask;
+	/*
+	 * Update part of the register affected by the emulated instruction.
+	 *
+	 * 32-bit operands generate a 32-bit result, zero-extended to a 64-bit
+	 * result.
+	 */
+	if (size < 4)
+		regs->ax &= ~mask;
+	else
+		regs->ax = 0;
+
 	if (success)
 		regs->ax |= args.r11 & mask;
 
-- 
2.51.2


