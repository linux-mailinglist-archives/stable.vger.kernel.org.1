Return-Path: <stable+bounces-100482-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 22B489EBA1B
	for <lists+stable@lfdr.de>; Tue, 10 Dec 2024 20:25:18 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id D56E6283BD9
	for <lists+stable@lfdr.de>; Tue, 10 Dec 2024 19:25:15 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 88889214232;
	Tue, 10 Dec 2024 19:25:13 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="R7TgPUlL"
X-Original-To: stable@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 492F023ED63
	for <stable@vger.kernel.org>; Tue, 10 Dec 2024 19:25:12 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1733858713; cv=none; b=MWxndc5p7/TQJFjs10UE/x8Cmx76Nst+46AAdJaHX4/mmoX4YuY6H4cVT7YMRzkqXeTuUhIASpCw/6MHiU+DkM0Sk2IKG2Qs1vjN/2hnCNgq4g4KSP9MA2jx2Zrs4CL7xbEEoWtpzYOij2nM2JlyhFF9VtKuhdQQ6hXbIQmy4TQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1733858713; c=relaxed/simple;
	bh=YZxrWfJQ3UmvxR0MUHPZzaQh3ibpMeL691R4nT0rnEw=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=Sd1uQMtatayDwuCsUOlck2RjiEJMAp3DLqXrqR+Ka9OGa0HiL2Ddom8HfegchxaFQUbO7QbVvpqq1vyTLDUwnFx2UgNF7WPqKMVod0eIqWoMtgB7ZZ6V8P5fGd/GgtY9w9Md+/pe7zD5ijZbUKkSEhWwOmikXyTFpRkGfx8Z1Sg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=R7TgPUlL; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 61675C4CED6;
	Tue, 10 Dec 2024 19:25:12 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1733858712;
	bh=YZxrWfJQ3UmvxR0MUHPZzaQh3ibpMeL691R4nT0rnEw=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=R7TgPUlLLVzYU42I1RVGpxARvR3UoPHCeOJlrrP4Gu5uZHju81No4FL8WtKWLLcv/
	 M0/59wzXT9b2tE25pB43KuhyjL8ZNX1ml+XTaEXTLMNoiNEskJBUbzZ4sLNTUrbALg
	 iWxRBSPpA4jQoPFXzefL4q0YOev31NmMS4FtIqi+e+nNg2K3dbG3uzPsxtBX8Hh8Pv
	 5rLTzWWBHLXfIdGJjh7aAhLEiB6XWD+KNVUnTLZP9dGZfQ4W6Z1KrzTrl8yrPOd5eO
	 gn+vbdnGC0mIiXGgYlnZn1nYSX0ix9NutgQGE9jkfHwqxtUiidIJcILAhHrHVXOFel
	 vXg6u4uZnzF8Q==
From: Sasha Levin <sashal@kernel.org>
To: stable@vger.kernel.org
Cc: Sergey Senozhatsky <senozhatsky@chromium.org>,
	Sasha Levin <sashal@kernel.org>
Subject: Re: [PATCH 5.10.y] modpost: Add .irqentry.text to OTHER_SECTIONS
Date: Tue, 10 Dec 2024 14:25:11 -0500
Message-ID: <20241210085807-5a9ba1649dfebfc6@stable.kernel.org>
X-Mailer: git-send-email 2.43.0
In-Reply-To:  <20241210111211.1895944-1-senozhatsky@chromium.org>
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

Note: The patch differs from the upstream commit:
---
1:  7912405643a14 < -:  ------------- modpost: Add .irqentry.text to OTHER_SECTIONS
-:  ------------- > 1:  8ccdbcbc2bb4b modpost: Add .irqentry.text to OTHER_SECTIONS
---

Results of testing on various branches:

| Branch                    | Patch Apply | Build Test |
|---------------------------|-------------|------------|
| stable/linux-5.10.y       |  Success    |  Success   |

