Return-Path: <stable+bounces-114337-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id E1F70A2D102
	for <lists+stable@lfdr.de>; Fri,  7 Feb 2025 23:51:24 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 80A6E16D60C
	for <lists+stable@lfdr.de>; Fri,  7 Feb 2025 22:51:23 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 778351B040E;
	Fri,  7 Feb 2025 22:51:23 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="SSEmh2hn"
X-Original-To: stable@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 389A11AF0AF
	for <stable@vger.kernel.org>; Fri,  7 Feb 2025 22:51:23 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1738968683; cv=none; b=IdyFRqbsLx3rLe/XrFvaTohThmBNmDKOaEpTbYDLUD4RUc9F0lD14W3JdmmPlN7eRcnpTM0ufVRZiZfL2RoIrd7VwZ9gRRGhvVpNVDO6+CgIuRXJE4vWn7PNJepcQTpcx3sx586eErMMg4/NIZkl5OaxCD8aoQ/3CyfBEYRIDPw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1738968683; c=relaxed/simple;
	bh=Zam5pZKIkHKaaWwsMO6i4oP6CYlJY1OH0W/rIkzw20c=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=Wehf+0t9ac5orR67eEzfSXLg7boHv7iSqxPz7kpVwsdWyYlg8n9C3AgupdwSfQ3p13h/7uhwMkpBfnHH1WdNRUhCCyrgiqJZ6LZbGdqrgl1t3BnYXe8540Cpanrbc3r+SEDSkvZkExlnnaQ7dp1LM0uSroku0vQ9LqBfGFk/QfA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=SSEmh2hn; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id A75EAC4CED1;
	Fri,  7 Feb 2025 22:51:22 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1738968683;
	bh=Zam5pZKIkHKaaWwsMO6i4oP6CYlJY1OH0W/rIkzw20c=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=SSEmh2hnizJ97R1uZdDXRl6GhZHK44Gy2nmiwT8r4ur+BqQLapes/Ao7IFfuC4fgs
	 rR4OkmVw+OOucU8Lh6hMU99ZtsHLffwz3piL8KPCbEYxpNfK7mKUH6baD/oVi3djWy
	 qbaY+kFsv2+31DBgZr1pOvrbCIUn0b4wBq/FlgWGm+WHH4PpcjJku5xA2Kl2VlwQAL
	 EOvAluTiG7hdR9BVNkmVf3SsGF7+Aq18Fo1YzCW8oTaiATwucmG6WlQTpSEWdnNZNz
	 TVjMs9QSKM6ZMHcBHivzryxnTHYOIprN7S2H96y+2v//JJ/GAdbriA+6Y9wg80dE1f
	 iyhEyzEKx9aag==
From: Sasha Levin <sashal@kernel.org>
To: stable@vger.kernel.org
Cc: James Houghton <jthoughton@google.com>,
	Sasha Levin <sashal@kernel.org>
Subject: Re: [PATCH 6.6.y 1/2] KVM: x86: Make x2APIC ID 100% readonly
Date: Fri,  7 Feb 2025 17:51:21 -0500
Message-Id: <20250207163552-fde618cd788c171e@stable.kernel.org>
X-Mailer: git-send-email 2.39.5
In-Reply-To:  <20250205222651.3784169-2-jthoughton@google.com>
References: 
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable

[ Sasha's backport helper bot ]

Hi,

Found matching upstream commit: 4b7c3f6d04bd53f2e5b228b6821fb8f5d1ba3071

WARNING: Author mismatch between patch and found commit:
Backport author: James Houghton<jthoughton@google.com>
Commit author: Sean Christopherson<seanjc@google.com>


Status in newer kernel trees:
6.13.y | Present (exact SHA1)
6.12.y | Present (exact SHA1)
6.6.y | Not found

Note: The patch differs from the upstream commit:
---
1:  4b7c3f6d04bd5 ! 1:  60f5174104fc8 KVM: x86: Make x2APIC ID 100% readonly
    @@ Commit message
         Signed-off-by: Sean Christopherson <seanjc@google.com>
         Message-ID: <20240802202941.344889-2-seanjc@google.com>
         Signed-off-by: Paolo Bonzini <pbonzini@redhat.com>
    +    (cherry picked from commit 4b7c3f6d04bd53f2e5b228b6821fb8f5d1ba307=
1)
    +    Signed-off-by: James Houghton <jthoughton@google.com>
=20=20=20=20=20
      ## arch/x86/kvm/lapic.c ##
     @@ arch/x86/kvm/lapic.c: static void kvm_recalculate_logical_map(struc=
t kvm_apic_map *new,
---

Results of testing on various branches:

| Branch                    | Patch Apply | Build Test |
|---------------------------|-------------|------------|
| stable/linux-6.6.y        |  Success    |  Failed    |

Build Errors:
Build error for stable/linux-6.6.y:
    ssh: connect to host 192.168.1.58 port 22: No route to host=0D

