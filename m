Return-Path: <stable+bounces-231402-lists+stable=lfdr.de@vger.kernel.org>
Delivered-To: lists+stable@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id wFjaAmivy2kpKAYAu9opvQ
	(envelope-from <stable+bounces-231402-lists+stable=lfdr.de@vger.kernel.org>)
	for <lists+stable@lfdr.de>; Tue, 31 Mar 2026 13:26:32 +0200
X-Original-To: lists+stable@lfdr.de
Received: from sin.lore.kernel.org (sin.lore.kernel.org [104.64.211.4])
	by mail.lfdr.de (Postfix) with ESMTPS id 27BC0368B41
	for <lists+stable@lfdr.de>; Tue, 31 Mar 2026 13:26:31 +0200 (CEST)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sin.lore.kernel.org (Postfix) with ESMTP id AB22B300BCA7
	for <lists+stable@lfdr.de>; Tue, 31 Mar 2026 11:24:42 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 286BD3D75D8;
	Tue, 31 Mar 2026 11:24:39 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="huJJwLnw"
X-Original-To: stable@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D80423D6CCB;
	Tue, 31 Mar 2026 11:24:38 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1774956278; cv=none; b=Xih2GteSFc9VNf8Xcda1M+3uABHV10tDiziVggzPkd3qUFuyYRzf1zHyuAgMhLS/sHOcAfS2+Nxc/q/AtYccq9aurdBpl7M4JynEP0zrleKt5hXTyc0zEUbs8dyr1RraCVMIdOt2Yfs+/CHvbZfMnHMVhDG6du1OaSssqV5yR1g=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1774956278; c=relaxed/simple;
	bh=6S53WwHQBySSlIR60mL5qHjCpnASH3lYQxz06R8Z8mo=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=gNJELQXOsLGG699w4ZHZXPBKX8MvFcOB0B1QJ1LW3W1LXUGcsVEdVmw/VFgnD81dI9BSVbsjs48ahdpUIhCm/bd6BP1cAPv0L9RZLQ3XmoUPCbgoVa64K7pW9cgvba3j4H5PEe4pZvy1Nct93fwp/6uZi0mWlPnvctSMgO+NSAo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=huJJwLnw; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id F1DE8C2BC9E;
	Tue, 31 Mar 2026 11:24:37 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1774956278;
	bh=6S53WwHQBySSlIR60mL5qHjCpnASH3lYQxz06R8Z8mo=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=huJJwLnwBJ1AFRfREQlmrimehJ0Z2ICE4X7BOi9VSvVJmQEViOT1WkgKv8dBttEYM
	 ZJPqtAETMFKns2eFlRbiyimDKy4EILoxGOywtwAmJEJjfomzuVbw7jlkW8QeImQN/h
	 yXMr42vhCRjWRBanLGlLWPukPJFhbyQcdZcFqXQrwzTdpYYz32NeWzR9lMWCRlBFaC
	 69COM0Dg3givlnyS8Yy7QbVbd3hCfFePnp4tzzrokbOa4vYtFbqOzO/fqiA4e39bh6
	 7FTHeI1xbpWRaD+BRPm47rH5CgCSe0OKl6Wt7J/sbIKSG4na8toa1CRZHafeiVu0XP
	 kBhQUW46IGL9A==
Received: from phl-compute-04.internal (phl-compute-04.internal [10.202.2.44])
	by mailfauth.phl.internal (Postfix) with ESMTP id 2C975F40069;
	Tue, 31 Mar 2026 07:24:37 -0400 (EDT)
Received: from phl-frontend-04 ([10.202.2.163])
  by phl-compute-04.internal (MEProxy); Tue, 31 Mar 2026 07:24:37 -0400
X-ME-Sender: <xms:9a7LaRcIeN7s0VgtILZboMJx__bPTvzEVC8sLU6NWvr3_5xvfPHjJQ>
    <xme:9a7Laeo_-xJFcqEQjeWH-rwSYiARS-yads9cZIkVCfT18MJQwoim-6GfY4siOjcBP
    2HVhnvsKwUGmQaBd4_Pi8bpFOie8C3istV9K0uMhY0FMNiCyrmxhQI>
X-ME-Received: <xmr:9a7Labl3STxyJYQjJ8U5tTzrEZViZRzjkfsPuJkNo9mEeatsbzIBxSkNrcgEbQ>
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
X-ME-Proxy: <xmx:9a7LafSiDq0cjeieX4VnV9ezqY9CrgUPq5-QosYIeE5A-1YIxBBPNg>
    <xmx:9a7LaRYKdgcm-BhrIfMS2FssbybAnHBUaam9uAyJp_aqCvnhkk3Vhg>
    <xmx:9a7Laf_eK_G-QVBKFL0KscU2fO4kyWoDHm4S1ZNzI5rotIJCh_4HCQ>
    <xmx:9a7LaTkXxun79fTNDKIdd6NAvJ2Z3grtBkt-rcUnaeNls-sCh-0QAA>
    <xmx:9a7LacZ4dAz8BQ2cK9N1-bERw6Wm88aQVfxAoXl1eR3DqQZGZe1pcFvx>
Feedback-ID: i10464835:Fastmail
Received: by mail.messagingengine.com (Postfix) with ESMTPA; Tue,
 31 Mar 2026 07:24:36 -0400 (EDT)
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
Subject: [PATCH 1/2] x86/tdx: Fix off-by-one in port I/O handling
Date: Tue, 31 Mar 2026 12:24:29 +0100
Message-ID: <20260331112430.71425-2-kas@kernel.org>
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
	R_SPF_ALLOW(-0.20)[+ip4:104.64.211.4:c];
	R_DKIM_ALLOW(-0.20)[kernel.org:s=k20201202];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	FREEMAIL_CC(0.00)[kernel.org,zytor.com,intel.com,linux.intel.com,gmail.com,vger.kernel.org,lists.linux.dev];
	RCPT_COUNT_TWELVE(0.00)[14];
	MIME_TRACE(0.00)[0:+];
	TAGGED_FROM(0.00)[bounces-231402-lists,stable=lfdr.de];
	FORGED_SENDER_MAILLIST(0.00)[];
	RCVD_TLS_LAST(0.00)[];
	ASN(0.00)[asn:63949, ipnet:104.64.192.0/19, country:SG];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[kas@kernel.org,stable@vger.kernel.org];
	FROM_HAS_DN(0.00)[];
	DKIM_TRACE(0.00)[kernel.org:+];
	DBL_BLOCKED_OPENRESOLVER(0.00)[sin.lore.kernel.org:helo,sin.lore.kernel.org:rdns];
	TAGGED_RCPT(0.00)[stable];
	NEURAL_HAM(-0.00)[-1.000];
	TO_DN_SOME(0.00)[];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	RCVD_COUNT_SEVEN(0.00)[7]
X-Rspamd-Queue-Id: 27BC0368B41
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
Signed-off-by: Kiryl Shutsemau (Meta) <kas@kernel.org>
Cc: stable@vger.kernel.org
---
 arch/x86/coco/tdx/tdx.c | 4 ++--
 1 file changed, 2 insertions(+), 2 deletions(-)

diff --git a/arch/x86/coco/tdx/tdx.c b/arch/x86/coco/tdx/tdx.c
index 7b2833705d47..4d7f71d50122 100644
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
2.51.2


