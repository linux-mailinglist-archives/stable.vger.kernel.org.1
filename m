Return-Path: <stable+bounces-124901-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 2A8EFA68A09
	for <lists+stable@lfdr.de>; Wed, 19 Mar 2025 11:54:20 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 893CA19C283C
	for <lists+stable@lfdr.de>; Wed, 19 Mar 2025 10:54:25 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 64DD3253B6F;
	Wed, 19 Mar 2025 10:54:15 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="KHnMLXrc"
X-Original-To: stable@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 25315251796
	for <stable@vger.kernel.org>; Wed, 19 Mar 2025 10:54:14 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1742381655; cv=none; b=J+aN1rbWRTTyntZKkvrR5x9h67I2XsdAK6Ybrxtw6RHW5FpQkBuURaRVZA3UMKsMwVZ3+X0ulMuXBtM98T/y6YaF/TDYH689m0JQl1fUtkhC+pUU/BYXy1sRpCGeXUzWHWRIC1mSK9+0HjVVn96gPG3ubJ0GTGhvh35+Tpe7JFA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1742381655; c=relaxed/simple;
	bh=iabQcDRsjnNC7ZsUCzc/QsoKGs77YHdkQgq9jB1d/W0=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=KOK3YlNY9cfZGYBzPB9tjlB6BBh6fA1ZTXCyn/6SHci7F62mahoqbUKlSuMdvJhSUaDhCyQNapZ9Wrp3bkb0B8NibF6EnbxnqNJvaZQgaSYMMTu0ZkJVX4//5/ewiwhYl70WWYq/hjBugueoKjqXBHAwfpjcgIQsYujNJAJUDi0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=KHnMLXrc; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 0B85DC4CEE9;
	Wed, 19 Mar 2025 10:54:13 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1742381654;
	bh=iabQcDRsjnNC7ZsUCzc/QsoKGs77YHdkQgq9jB1d/W0=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=KHnMLXrc8Vco35QPWnvbtnn1qSRoM9zwsjZMy3wIca0rCDkdmQaYi9gx4gN00IGkC
	 IQvLdYm+jf4a9KlAkQoUfEoKBLRLq/Vh3PgjBFnxgDAOP0ygHskhgmA2hDOcw77uSa
	 3yGL3xgaiuQLZ6SvTk4bkh8LNAE8nAmPS65I4kUwbejt+kpiW0jAc+PwbuWz+dvecU
	 NsXxV/qymFTI7G1TIIlut+Kt/wxdS0wWf8gsN3eeb8biyL+OmC+Hab5ciTsk89LASJ
	 yDA7fH6d8Z2A/RlVbiot8mNBxXlWi+63UKXxo0dt0xUqvicWU1HyVl4H31a1iiGEbJ
	 DOy6m6IQ1ZaEA==
From: Sasha Levin <sashal@kernel.org>
To: stable@vger.kernel.org
Cc: jianqi.ren.cn@windriver.com,
	Sasha Levin <sashal@kernel.org>
Subject: Re: [PATCH 5.15.y] smb: client: fix potential UAF in cifs_debug_files_proc_show()
Date: Wed, 19 Mar 2025 06:54:12 -0400
Message-Id: <20250319054204-7273c703fea9a4e0@stable.kernel.org>
X-Mailer: git-send-email 2.39.5
In-Reply-To:  <20250319030139.953922-1-jianqi.ren.cn@windriver.com>
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

The upstream commit SHA1 provided is correct: ca545b7f0823f19db0f1148d59bc5e1a56634502

WARNING: Author mismatch between patch and upstream commit:
Backport author: <jianqi.ren.cn@windriver.com>
Commit author: Paulo Alcantara<pc@manguebit.com>

Status in newer kernel trees:
6.13.y | Present (exact SHA1)
6.12.y | Present (exact SHA1)
6.6.y | Present (different SHA1: a65f2b56334b)
6.1.y | Present (different SHA1: 229042314602)

Note: The patch differs from the upstream commit:
---
1:  ca545b7f0823f < -:  ------------- smb: client: fix potential UAF in cifs_debug_files_proc_show()
-:  ------------- > 1:  374668b862d38 smb: client: fix potential UAF in cifs_debug_files_proc_show()
---

Results of testing on various branches:

| Branch                    | Patch Apply | Build Test |
|---------------------------|-------------|------------|
| stable/linux-5.15.y       |  Success    |  Success   |

