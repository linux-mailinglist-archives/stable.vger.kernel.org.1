Return-Path: <stable+bounces-132357-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id CB834A872EC
	for <lists+stable@lfdr.de>; Sun, 13 Apr 2025 19:18:17 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 314BE1893583
	for <lists+stable@lfdr.de>; Sun, 13 Apr 2025 17:18:24 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 7F3FA1EF38E;
	Sun, 13 Apr 2025 17:18:09 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="g6Ax8Ugd"
X-Original-To: stable@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 40AE61EF37E
	for <stable@vger.kernel.org>; Sun, 13 Apr 2025 17:18:09 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1744564689; cv=none; b=UY2C5TgRUVbPRS90ckJE3rEvqocyguWuY0MaNnd2SwdGVj4B514QQN3jHNqAawOExDUk7upbUI5wsv+DomBjtkGXecXg8xthyxIigq8N7AGRfmeZVtmLqHtFkPL2R4YoH3HjWf6sT5P17iqZ0Uq/bVIQn0hlLk5Zttqmay1Pftk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1744564689; c=relaxed/simple;
	bh=QwwF3ck20idiEkQ1MmFT6iCiM4hl2CcAj/Vesb5usL8=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version:Content-Type; b=I+Ku6nt0jquDW9BUbbcVgq+aKrHaox64uHAFDu1Q4JdgNCqeBjel92Oa+nQKs7Zvu6IcyphnjyLNzZWsQTKhQrfDDESy1PBlVyKbPMb6w/Z4QeG52oUYNu6jMLuIhhyVJ7infa5Pufz2U+j1iSHqF0prg2fGBxDSHIKnYGo5vKE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=g6Ax8Ugd; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 83627C4CEDD;
	Sun, 13 Apr 2025 17:18:08 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1744564689;
	bh=QwwF3ck20idiEkQ1MmFT6iCiM4hl2CcAj/Vesb5usL8=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=g6Ax8UgdDHn7nY4Tq7wubufB5InPZR5ILjFey7aQlO+LvXwaFGGwDYu4zBNooZMTI
	 0cOKbErczQU5MLLe7REzmxecldsYnCAIvnVsjPF3N46gpZiYkQfSkoTwTiZHpLxx0n
	 p9nt+GEx++HMmd448FB9l/z+6dDPHQpHcdeNX9r+HUdEsny5JtvfJd855GE0SEcAiB
	 ZU0tMqY6Yr3YunSk778y8MuF0gfKAOnQYan7PZA6wPoFC3aCaWZ68I7lJ89slE9RtF
	 MIHIFKDEqeKF6ldiRkcQOKG3Y/lkXkfZtfpzqhERK0pAr2D/OFpNbjE0PwOMz+zC3o
	 eQ/wi3X9+KaOQ==
From: Sasha Levin <sashal@kernel.org>
To: stable@vger.kernel.org,
	ojeda@kernel.org
Cc: Sasha Levin <sashal@kernel.org>
Subject: Re: [PATCH] objtool/rust: add one more `noreturn` Rust function
Date: Sun, 13 Apr 2025 13:18:07 -0400
Message-Id: <20250413131421-3e7c4d5c868c4f09@stable.kernel.org>
X-Mailer: git-send-email 2.39.5
In-Reply-To:  <20250413002338.1741593-1-ojeda@kernel.org>
References: 
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit

[ Sasha's backport helper bot ]

Hi,

Summary of potential issues:
⚠️ Found matching upstream commit but patch is missing proper reference to it

Found matching upstream commit: cee6f9a9c87b6ecfb51845950c28216b231c3610

Note: The patch differs from the upstream commit:
---
1:  cee6f9a9c87b6 < -:  ------------- objtool/rust: add one more `noreturn` Rust function
-:  ------------- > 1:  a6ee72c789bbc objtool/rust: add one more `noreturn` Rust function
---

Results of testing on various branches:

| Branch                    | Patch Apply | Build Test |
|---------------------------|-------------|------------|
| stable/linux-6.14.y       |  Success    |  Success   |
| stable/linux-6.13.y       |  Success    |  Success   |
| stable/linux-6.12.y       |  Success    |  Success   |
| stable/linux-6.6.y        |  Success    |  Success   |
| stable/linux-6.1.y        |  Success    |  Success   |
| stable/linux-5.15.y       |  Success    |  Success   |
| stable/linux-5.10.y       |  Success    |  Success   |
| stable/linux-5.4.y        |  Success    |  Success   |

