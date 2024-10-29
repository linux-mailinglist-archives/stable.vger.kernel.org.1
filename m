Return-Path: <stable+bounces-89209-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id AD6D09B4B9E
	for <lists+stable@lfdr.de>; Tue, 29 Oct 2024 15:01:48 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id CFDEB1C22CA3
	for <lists+stable@lfdr.de>; Tue, 29 Oct 2024 14:01:47 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 6A443206E67;
	Tue, 29 Oct 2024 14:01:42 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=jfarr.cc header.i=@jfarr.cc header.b="l1igGmFB";
	dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b="NGoSjQLb"
X-Original-To: stable@vger.kernel.org
Received: from fhigh-a6-smtp.messagingengine.com (fhigh-a6-smtp.messagingengine.com [103.168.172.157])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 73C1F42A92;
	Tue, 29 Oct 2024 14:01:39 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=103.168.172.157
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1730210502; cv=none; b=DsPWf//vdKIHMTNKB+ejnwv+2RiJxPSQ+lSUDtXO3oDnuT+E85O1jq7peyTZH1uN1W44GqRNnJ9+xBNNSjkJJt2XLLuErhCFg8OxQXI+DeOLJ/2AU/MHPN3muJqhiSC5iIw3n4L5Tks375Hf+weqi27M3aG1kTEVjn2W7ndS9Dw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1730210502; c=relaxed/simple;
	bh=lrEcALA54EnYbsUNXZKeqw58RzvlXHhpQO01rUMxDn8=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=CfqZpWWKTGz8mXLbRYVuzBiTXxDn2MlwKdLoKje+OjlZJt9sGsQWp9O2KMJXeT7gY0tfCAZO7JSTqPmoEpI01ljcx0NSabWvTihhR4h9FhabrH7TnTbiXBV0YHU8CliY/yLiABJRsHQ3CQXp7CazWarQhuMbJpt5/9L4mG56aX8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=jfarr.cc; spf=pass smtp.mailfrom=jfarr.cc; dkim=pass (2048-bit key) header.d=jfarr.cc header.i=@jfarr.cc header.b=l1igGmFB; dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b=NGoSjQLb; arc=none smtp.client-ip=103.168.172.157
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=jfarr.cc
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=jfarr.cc
Received: from phl-compute-12.internal (phl-compute-12.phl.internal [10.202.2.52])
	by mailfhigh.phl.internal (Postfix) with ESMTP id A096C11400FE;
	Tue, 29 Oct 2024 10:01:38 -0400 (EDT)
Received: from phl-mailfrontend-02 ([10.202.2.163])
  by phl-compute-12.internal (MEProxy); Tue, 29 Oct 2024 10:01:38 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=jfarr.cc; h=cc
	:cc:content-transfer-encoding:content-type:date:date:from:from
	:in-reply-to:message-id:mime-version:reply-to:subject:subject:to
	:to; s=fm2; t=1730210498; x=1730296898; bh=p4jsg3LM+d9z1ul1hzPOU
	tHu1EHhd/xb0I4yaFVNKtI=; b=l1igGmFBYfP+rqdbAOk/oAjd+FpPgcJp7aYtx
	FkhN7w/ste9oPDLfVkhLmW3MetFKSfSOCLI8o5CQw6Vt7U/OYk2YbMJm/VH7WoKU
	LS74TjW7zSUcKsfzW0vfH9KWQ/ene7eIA9ijobdr0EyeU1tzFVK/SAV3YgjLRQ59
	/PLftZ0HEebWv/7/aRpaJr7iA6LGUyQFRPemIIod+kv/p3xvNn9+UV4W4GI27JwO
	d6zJ6SA2rINMlHMp3CiNphb7xvtnOI4ih5dqyGE+KoR7AraxYpguw6GODtZ6iddf
	08M+eKJAVGpiNbXURf9kcb8aFPwyIv5kHTsrklpa+P8imr5Qg==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
	messagingengine.com; h=cc:cc:content-transfer-encoding
	:content-type:date:date:feedback-id:feedback-id:from:from
	:in-reply-to:message-id:mime-version:reply-to:subject:subject:to
	:to:x-me-proxy:x-me-sender:x-me-sender:x-sasl-enc; s=fm3; t=
	1730210498; x=1730296898; bh=p4jsg3LM+d9z1ul1hzPOUtHu1EHhd/xb0I4
	yaFVNKtI=; b=NGoSjQLbkYEqNFzwq/YrHsW1c2tdnR7KSbG1YCn/fSr8eEK+FcH
	zTT3icvAUzVt5k3HfYfRovDpFEukd+qwbel9VIBPaROHhciq1RH6nnXxBMoF5RAV
	gzD4lXGkZc9wNJNyNx2ZS5kCUrxwm+Twx4Cufy1L0G3db8as5Ro7fmzlOD1iyApc
	d4fpr54l5CtOif8s6EJ++h+NHcCg2YMIA8etSvRATKQ5gdRBpsTxIS1s3XZd90lE
	uGAgVQnzL2KIOBjM9P6u+7jH0WDiRMF0mO1swICpUXXukBcJASaX1veqhvb8a6UX
	V1pUMpsSHTvjGSUwOQ3oKrKjRdCI13JeSkQ==
X-ME-Sender: <xms:weogZ7E8p7NBxuD3kPFzIkAmIRS7BZNMCKkP8wzRN0yMnPyvie9eVw>
    <xme:weogZ4X53XcWE1kA4vrKEMt_zCeneApyfQMv5zPXmdA9kkho5EvQMc3qnUUmG85HV
    qKbrm1HJh1qZMF8xNo>
X-ME-Received: <xmr:weogZ9ITrctCXhR1ptzuL_6VkKEnFMmYCHSIVAzlPXVo_voY39DUqP8jz1TkH69zw-MvHWqDS8_YsoW-d7TaBmgIM51KIGM>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgeeftddrvdekuddgheehucetufdoteggodetrfdotf
    fvucfrrhhofhhilhgvmecuhfgrshhtofgrihhlpdggtfgfnhhsuhgsshgtrhhisggvpdfu
    rfetoffkrfgpnffqhgenuceurghilhhouhhtmecufedttdenucgfrhhlucfvnfffucdlud
    dtmdenucfjughrpefhvfevufffkffoggfgsedtkeertdertddtnecuhfhrohhmpeflrghn
    ucfjvghnughrihhkucfhrghrrhcuoehkvghrnhgvlhesjhhfrghrrhdrtggtqeenucggtf
    frrghtthgvrhhnpeeluddtuedtieeguefhleefkefhieefkeetheehvdetieevhfethfet
    uedtffegffenucffohhmrghinhepghhithhhuhgsrdgtohhmpdhkvghrnhgvlhdrohhrgh
    enucevlhhushhtvghrufhiiigvpedtnecurfgrrhgrmhepmhgrihhlfhhrohhmpehkvghr
    nhgvlhesjhhfrghrrhdrtggtpdhnsggprhgtphhtthhopedvtddpmhhouggvpehsmhhtph
    houhhtpdhrtghpthhtohepkhgvvghssehkvghrnhgvlhdrohhrghdprhgtphhtthhopehn
    rghthhgrnheskhgvrhhnvghlrdhorhhgpdhrtghpthhtohepohhjvggurgeskhgvrhhnvg
    hlrdhorhhgpdhrtghpthhtohepnhguvghsrghulhhnihgvrhhssehgohhoghhlvgdrtgho
    mhdprhgtphhtthhopehmohhrsghosehgohhoghhlvgdrtghomhdprhgtphhtthhopehjuh
    hsthhinhhsthhithhtsehgohhoghhlvgdrtghomhdprhgtphhtthhopehthhhorhhsthgv
    nhdrsghluhhmsehtohgslhhugidrtghomhdprhgtphhtthhopegrrhgusgeskhgvrhhnvg
    hlrdhorhhgpdhrtghpthhtohepohhlihhvvghrrdhsrghnghesihhnthgvlhdrtghomh
X-ME-Proxy: <xmx:wuogZ5GI-95yAf4Kgun4ov5k7PqiQKHJOZXxuP90MF_8fhGIGjokVg>
    <xmx:wuogZxUwu83Z9xKXf77HwVEG_-PC8JoBkeshapa23xitA8D8Fz3etA>
    <xmx:wuogZ0PzKNBzklIe40wkwWlknpN6Ollo31QoEg6kEhIBiqLHhlwuRg>
    <xmx:wuogZw1XXzoqbqnn_BatEnlyma0jZ2rGx10Cxw7Hm7dqKBFzp-Zgtw>
    <xmx:wuogZ-2Rf-8fLb3RpDYIFujIuX9-fpK5utLlCzg7uN___qX4ifPObDTM>
Feedback-ID: i01d149f8:Fastmail
Received: by mail.messagingengine.com (Postfix) with ESMTPA; Tue,
 29 Oct 2024 10:01:35 -0400 (EDT)
From: Jan Hendrik Farr <kernel@jfarr.cc>
To: kees@kernel.org
Cc: nathan@kernel.org,
	ojeda@kernel.org,
	ndesaulniers@google.com,
	morbo@google.com,
	justinstitt@google.com,
	thorsten.blum@toblux.com,
	ardb@kernel.org,
	oliver.sang@intel.com,
	gustavoars@kernel.org,
	kent.overstreet@linux.dev,
	arnd@arndb.de,
	gregkh@linuxfoundation.org,
	akpm@linux-foundation.org,
	tavianator@tavianator.com,
	linux-hardening@vger.kernel.org,
	llvm@lists.linux.dev,
	linux-kernel@vger.kernel.org,
	stable@vger.kernel.org,
	kernel@jfarr.cc
Subject: [PATCH 0/1] disable __counted_by for clang < 19.1.3
Date: Tue, 29 Oct 2024 15:00:35 +0100
Message-ID: <20241029140036.577804-1-kernel@jfarr.cc>
X-Mailer: git-send-email 2.47.0
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

Hi Kees,

Bill's PR to disable __counted_by for "whole struct" __bdos cases has now
been merged into 19.1.3 [1], so here's the patch to disable __counted_by
for clang versions < 19.1.3 in the kernel.

Hopefully in the near future __counted_by for whole struct __bdos can be
enabled once again in coordination between the kernel, gcc, and clang.
There has been recent progress on this in [2] thanks to Tavian.

Also see previous discussion on the mailing list [3]

Thanks to everyone for moving this issue along. In particular, Bill for
his PR to clang/llvm, Kees and Thorsten for reproducers of the two issues,
Nathan for Kconfig-ifying this patch, and Miguel for reviewing.


Info for the stable team:

This patch should be backported to kernels >= 6.6 to make sure that those
build correctly with the effected clang versions. This patch cherry-picks
cleanly onto linux-6.11.y. For linux-6.6.y three prerequiste commits are
neded:

16c31dd7fdf6: Compiler Attributes: counted_by: bump min gcc version
2993eb7a8d34: Compiler Attributes: counted_by: fixup clang URL
231dc3f0c936: lkdtm/bugs: Improve warning message for compilers without counted_by support

There are still two merge conflicts even with those prerequistes.
Here's the correct resolution:

1. include/linux/compiler_types.h:
	use the incoming change until before (but not including) the
        "Apply __counted_by() when the Endianness matches to increase test coverage."
        comment

2. lib/overflow_kunit.c: 
	HEAD is correct

[1] https://github.com/llvm/llvm-project/pull/112786
[2] https://github.com/llvm/llvm-project/pull/112636
[3] https://lore.kernel.org/lkml/3E304FB2-799D-478F-889A-CDFC1A52DCD8@toblux.com/T/#m204c09f63c076586a02d194b87dffc7e81b8de7b

Best Regards
Jan

Jan Hendrik Farr (1):
  Compiler Attributes: disable __counted_by for clang < 19.1.3

 drivers/misc/lkdtm/bugs.c           |  2 +-
 include/linux/compiler_attributes.h | 13 -------------
 include/linux/compiler_types.h      | 19 +++++++++++++++++++
 init/Kconfig                        |  9 +++++++++
 lib/overflow_kunit.c                |  2 +-
 5 files changed, 30 insertions(+), 15 deletions(-)

-- 
2.47.0


