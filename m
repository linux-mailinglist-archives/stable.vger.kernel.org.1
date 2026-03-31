Return-Path: <stable+bounces-231401-lists+stable=lfdr.de@vger.kernel.org>
Delivered-To: lists+stable@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id GFnDESywy2kpKAYAu9opvQ
	(envelope-from <stable+bounces-231401-lists+stable=lfdr.de@vger.kernel.org>)
	for <lists+stable@lfdr.de>; Tue, 31 Mar 2026 13:29:48 +0200
X-Original-To: lists+stable@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [IPv6:2600:3c0a:e001:db::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id 92BDD368C2B
	for <lists+stable@lfdr.de>; Tue, 31 Mar 2026 13:29:47 +0200 (CEST)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id D015030E5051
	for <lists+stable@lfdr.de>; Tue, 31 Mar 2026 11:24:38 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 896483CE488;
	Tue, 31 Mar 2026 11:24:37 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="sLCO2gzd"
X-Original-To: stable@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4ADB43BE153
	for <stable@vger.kernel.org>; Tue, 31 Mar 2026 11:24:37 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1774956277; cv=none; b=bjATiXs3e8F6gYhUaGdE/9YbCyyRgPO12MK8H8W3akgRzC0zzlhKIBHQJ7se0JwR5u57MQA8EQoGgpZG8CUAjUUUXHpvq2qiRm97IKAd6UaGgkFUzeQt0Nyr9+XWBYJ/l+s0mprjGZCT4tse7KpxDRNhMM+BtVkxgKEJdAWsl1U=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1774956277; c=relaxed/simple;
	bh=n/64B9MCKy0Lk/rrhSI3bikBv2jTmHGMEyUdsyuOvoQ=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=f1KBGC3MiL7wVEJtyvPX0cPWbh8imPIMY2VP++opVIJ9Gd5VR7sd5jbZeLjxabUWympCuiYtp+9q3X/tZx2WhWnbGA4SE6ehNiDhu3jS2FhXQfQpTNgU4eEl59ZK8gM4InIeP5e5K4rS52g0AQJ6a/XQCC2nH/jfp2UT2JQsttg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=sLCO2gzd; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 9D954C2BCB1;
	Tue, 31 Mar 2026 11:24:36 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1774956277;
	bh=n/64B9MCKy0Lk/rrhSI3bikBv2jTmHGMEyUdsyuOvoQ=;
	h=From:To:Cc:Subject:Date:From;
	b=sLCO2gzdOiPcI82ZsiqhEehWlc2rUJCgbo80v85n38+DpT3lx3MmXm2QZdUaMnql9
	 yym++G3rCYqZ4wMFtpsCHuYeSQrzXFTBG07p84e4v7KNn9VOQ+bryKqPoKbU5LWGUc
	 lOGfoL3U/w48fqgrswREx40da4xYVgb1WjwrvjaKKCTWxUbWtCoZjYtzuZ931ILfMA
	 oXxb9r1qaoMfk0pq08tqeSRMMeWQVPMdpyoptp/Y3owS5OGKciwX9WPFMWPJO9yfCg
	 vSFGKUcoFBcYvnVRAwR5Na2zbsGkmhXcpp5VSWk+mmusEGbk2lYneSj6BO6WDt48y2
	 iNKoBO3IS4qUA==
Received: from phl-compute-05.internal (phl-compute-05.internal [10.202.2.45])
	by mailfauth.phl.internal (Postfix) with ESMTP id A2386F40068;
	Tue, 31 Mar 2026 07:24:35 -0400 (EDT)
Received: from phl-frontend-04 ([10.202.2.163])
  by phl-compute-05.internal (MEProxy); Tue, 31 Mar 2026 07:24:35 -0400
X-ME-Sender: <xms:867LaSqV-yoGq_YPuFUJKuLjxw8xlWE0Xz3QgofMbXLLpsFn1oL4Qg>
    <xme:867LaQFjQV8FrfUNVkko0BGoEYpwDioBbGw-ZCZwpIOp0G3XFarKdFsVVlYdokNLT
    jci4_ZmI5HyQq7cmAFU5lH1tMpOWXwPCydd3ymLhXnZ3NOmwDTsp8cO>
X-ME-Received: <xmr:867LaYQS4QRawVxT9UwUTtbU9gMaeyQ2RiS1Kho-PD6ZaquWEyvBfdXGzrpWpA>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgeefhedrtddtgddtjecutefuodetggdotefrodftvf
    curfhrohhfihhlvgemucfhrghsthforghilhdpuffrtefokffrpgfnqfghnecuuegrihhl
    ohhuthemuceftddtnecusecvtfgvtghiphhivghnthhsucdlqddutddtmdenucfjughrpe
    fhvfevufffkffoggfgsedtkeertdertddtnecuhfhrohhmpedfmfhirhihlhcuufhhuhht
    shgvmhgruhculdfovghtrgdmfdcuoehkrghssehkvghrnhgvlhdrohhrgheqnecuggftrf
    grthhtvghrnhepteeikeffuddugfehkedtvdegteeifeetfedufeehkeffieetffffleei
    ieeuvefhnecuvehluhhsthgvrhfuihiivgeptdenucfrrghrrghmpehmrghilhhfrhhomh
    epkhhirhhilhhlodhmvghsmhhtphgruhhthhhpvghrshhonhgrlhhithihqdduieduudei
    vdeiheehqddvkeeggeegjedvkedqkhgrsheppehkvghrnhgvlhdrohhrghesshhhuhhtvg
    hmohhvrdhnrghmvgdpnhgspghrtghpthhtohepudegpdhmohguvgepshhmthhpohhuthdp
    rhgtphhtthhopehtghhlgieskhgvrhhnvghlrdhorhhgpdhrtghpthhtohepmhhinhhgoh
    esrhgvughhrghtrdgtohhmpdhrtghpthhtohepsghpsegrlhhivghnkedruggvpdhrtghp
    thhtohepuggrvhgvrdhhrghnshgvnheslhhinhhugidrihhnthgvlhdrtghomhdprhgtph
    htthhopeigkeeisehkvghrnhgvlhdrohhrghdprhgtphhtthhopehkrghssehkvghrnhgv
    lhdrohhrghdprhgtphhtthhopehhphgrseiihihtohhrrdgtohhmpdhrtghpthhtoheprh
    hitghkrdhprdgvughgvggtohhmsggvsehinhhtvghlrdgtohhmpdhrtghpthhtohepshgr
    thhhhigrnhgrrhgrhigrnhgrnhdrkhhuphhpuhhsfigrmhihsehlihhnuhigrdhinhhtvg
    hlrdgtohhm
X-ME-Proxy: <xmx:867LaWPt0QeZtrtCiF4ZuHAnS9m1z8auZ_vpPMObbF8qlahfyOXp2Q>
    <xmx:867LaVl10AH_PJz7ZomQ3COHsxQ7uvukFBpBG-weflMFB24pGGjR3A>
    <xmx:867LaYa8zcEzgrCW4z4JT4kT-SePmboyzGd75tO9TRiDRAzSUUBSag>
    <xmx:867LabSzLHaM3lzGjKseKTkdRPUn36y1ecM4WO2hFKENPaVSlLaHUQ>
    <xmx:867LaSWbH_AMYJ5g7z_gBZI0wixk_QHNb7zVJJx01ra6VnJvbYtGDVr1>
Feedback-ID: i10464835:Fastmail
Received: by mail.messagingengine.com (Postfix) with ESMTPA; Tue,
 31 Mar 2026 07:24:35 -0400 (EDT)
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
Subject: [PATCH 0/2] x86/tdx: Port I/O emulation fixes
Date: Tue, 31 Mar 2026 12:24:28 +0100
Message-ID: <20260331112430.71425-1-kas@kernel.org>
X-Mailer: git-send-email 2.51.2
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
	R_SPF_ALLOW(-0.20)[+ip6:2600:3c0a:e001:db::/64:c];
	R_DKIM_ALLOW(-0.20)[kernel.org:s=k20201202];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	FREEMAIL_CC(0.00)[kernel.org,zytor.com,intel.com,linux.intel.com,gmail.com,vger.kernel.org,lists.linux.dev];
	RCPT_COUNT_TWELVE(0.00)[14];
	MIME_TRACE(0.00)[0:+];
	TAGGED_FROM(0.00)[bounces-231401-lists,stable=lfdr.de];
	FORGED_SENDER_MAILLIST(0.00)[];
	RCVD_TLS_LAST(0.00)[];
	ASN(0.00)[asn:63949, ipnet:2600:3c0a::/32, country:SG];
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
X-Rspamd-Queue-Id: 92BDD368C2B
X-Rspamd-Action: no action
X-Rspamd-Server: lfdr

This series addresses two technical inaccuracies in the TDX guest port
I/O emulation code reported by Borys Tsyrulnikov.

The first patch fixes an off-by-one error in the GENMASK() macro usage
where the mask was being calculated as one bit too wide (e.g., 9 bits for
an 8-bit operation).

The second patch ensures that 32-bit port I/O operations (INL) correctly
zero-extend the result to the full 64-bit RAX register, as required by
 the x86 architecture. Currently, the emulation preserves the upper 32
bits of RAX during such operations.

Both issues were introduced in the initial implementation of the runtime
hypercalls for port I/O.

Kiryl Shutsemau (Meta) (2):
  x86/tdx: Fix off-by-one in port I/O handling
  x86/tdx: Fix zero-extension for 32-bit port I/O

 arch/x86/coco/tdx/tdx.c | 17 +++++++++++++----
 1 file changed, 13 insertions(+), 4 deletions(-)

-- 
2.51.2


