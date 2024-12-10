Return-Path: <stable+bounces-100471-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 198D09EBA10
	for <lists+stable@lfdr.de>; Tue, 10 Dec 2024 20:25:05 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 3A5F1188856C
	for <lists+stable@lfdr.de>; Tue, 10 Dec 2024 19:25:02 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 6A4BC214237;
	Tue, 10 Dec 2024 19:24:49 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="AhhWBzG7"
X-Original-To: stable@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2A57D23ED63
	for <stable@vger.kernel.org>; Tue, 10 Dec 2024 19:24:48 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1733858689; cv=none; b=ZohHgE/kqAsKQVm3BGyl4c9YOFVyWPVbOXaG0OfFDAtALuYXamUCaYGm5P3xvAMy86RV1b2a4ETqKAjy7udb1oaoff97EK7CW3l8yztDoBVCe6CpoyJp0qhG0KMStBNkvEXeWV5cmsdVGYSYgx9iqHoCDbKCARBhM3MjovcN8u8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1733858689; c=relaxed/simple;
	bh=LBn+1D6RC4s0ELT5T0t04OAWgxi34Csq4xGvsQIFrg8=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=nJmh4ffbDZBMt/7VL3IuPJhjEmJoKeRKno8d0Ko5JAquFStPXZOLj01/PzkzBkQw+E6hsOStj3z6n/w/ewh54coAxoTKgnoogehOZ2s45U4CvlNwmynVrk22CJMRMGnct4l7nUHJMqU8BRNkloxM/1GH0SRfF9icaktZQ1aayDs=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=AhhWBzG7; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 48C6CC4CED6;
	Tue, 10 Dec 2024 19:24:48 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1733858688;
	bh=LBn+1D6RC4s0ELT5T0t04OAWgxi34Csq4xGvsQIFrg8=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=AhhWBzG7uqpf8KHdfotdSJ3EZWmsywIgzNQgFk1jwoHDdLfkOFc/JqG6zwPw2rXtV
	 Fo1dughy45gO7vq963YqUNPfvoVAfbGiiANoYL5HI4Wjoi5wZeN8qTmcEKsp2OQBgd
	 UeLhsDKKbOK7TgGiY80EB/w1yUzlDC78/8UOXTy4H+aydY0tFklZ3DVjj7GjGDG2ve
	 mhMtLTgk0wT6zwsSY987QuYbRfh9BA/k2CxOmkxo0mVEFVjc765VjpeTR2SDgvelxQ
	 gqzWd6IYgIDD9oaKLvCfcfW9dM2nBmUmEk9iVNAERyR0iBLd5xDwZF40p+rZtC2Mwf
	 DMTjoqvDjNfug==
From: Sasha Levin <sashal@kernel.org>
To: stable@vger.kernel.org
Cc: Sergey Senozhatsky <senozhatsky@chromium.org>,
	Sasha Levin <sashal@kernel.org>
Subject: Re: [PATCH 5.4.y] modpost: Add .irqentry.text to OTHER_SECTIONS
Date: Tue, 10 Dec 2024 14:24:47 -0500
Message-ID: <20241210074529-6bed693c12152538@stable.kernel.org>
X-Mailer: git-send-email 2.43.0
In-Reply-To:  <20241210111320.1896474-1-senozhatsky@chromium.org>
References: 
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

[ Sasha's backport helper bot ]

Hi,

Found matching upstream commit: 7912405643a14b527cd4a4f33c1d4392da900888

WARNING: Author mismatch between patch and found commit:
Backport author: Sergey Senozhatsky <senozhatsky@chromium.org>
Commit author: Thomas Gleixner <tglx@linutronix.de>


Status in newer kernel trees:
6.12.y | Not found
6.6.y | Not found
6.1.y | Not found
5.15.y | Not found
5.10.y | Not found
5.4.y | Not found

Note: The patch differs from the upstream commit:
---
1:  7912405643a14 < -:  ------------- modpost: Add .irqentry.text to OTHER_SECTIONS
-:  ------------- > 1:  4384906dd88d5 modpost: Add .irqentry.text to OTHER_SECTIONS
---

Results of testing on various branches:

| Branch                    | Patch Apply | Build Test |
|---------------------------|-------------|------------|
| stable/linux-5.4.y        |  Success    |  Success   |

