Return-Path: <stable+bounces-132788-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id BC665A8AA43
	for <lists+stable@lfdr.de>; Tue, 15 Apr 2025 23:43:26 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 0B2E67A5B9F
	for <lists+stable@lfdr.de>; Tue, 15 Apr 2025 21:42:15 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 250562580F5;
	Tue, 15 Apr 2025 21:43:20 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="WeYYGhWj"
X-Original-To: stable@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D9CC82580C2
	for <stable@vger.kernel.org>; Tue, 15 Apr 2025 21:43:19 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1744753399; cv=none; b=bWWi7OoK35SCx8LvVSl0JhL8+0mqCZwSjcdxWOaUrTCbR9V4AyT4WvLi3dfpYq0c0sKHncG9XYIckRCW1Tu3Q+m2xIGzGOxDYqc4/dipDw1zHeZJkc2En1CtRyGobNybifufzsbWJ8M80/Va7BzWwBDTlCSpY+WUaGycplPjeQw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1744753399; c=relaxed/simple;
	bh=HfrXqnxWNcnqZDTPU8XxVn8y8TSwQJVvbyHQJ9ylH94=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version:Content-Type; b=ccl0er+rLbI47DD8FK+masR727mSUpqtlGmzE0XBfWWCHZG5hhROI+sigrS8g8T2ewU/zFdDt2P5Cb1G7SctKAlBX8goaWuGqADVaeBa8EaAKYFWiGU+Ngk4fCKH78kMv15qy2X9SgX6GUsSe4eyFthuUyvKLqGB2Pu8bcQkmno=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=WeYYGhWj; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id DB80EC4CEE7;
	Tue, 15 Apr 2025 21:43:18 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1744753399;
	bh=HfrXqnxWNcnqZDTPU8XxVn8y8TSwQJVvbyHQJ9ylH94=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=WeYYGhWjxDfQsVTglhKhkN8R1LopuWRXaMZTvQsAHd2HknTYEGDDuuu2hlDFPlduz
	 AEpdm8QmYygQ8VNIOuXvkuxk6T0LZK2IWUTNsCQniMU38ZXnU2WjdaR34EYn6+tNTy
	 euh4frJVJqCCZqQnWNcFP+MeumCEK0FDbmj8XSDYcvePJSUDTeCrabqLxVxHAdDmZa
	 NQbSC3ex8q12N5kFuJcXqWC2I7gOSj9/OBcbbmfU/dR7Lvk7Ob2sQ+XtJc4W7zQFz8
	 5ReD/deEf2jQKDBhZ0/4y/Et9qwVytRwzArE3KyozJo9l6cxilVdiP5xo08BXkXqaz
	 xRBKkYrkmCV5g==
From: Sasha Levin <sashal@kernel.org>
To: stable@vger.kernel.org
Cc: Zenm Chen <zenmchen@gmail.com>,
	Sasha Levin <sashal@kernel.org>
Subject: Re: [PATCH v2 6.6.y 1/2] wifi: rtw89: pci: add pre_deinit to be called after probe complete
Date: Tue, 15 Apr 2025 17:43:17 -0400
Message-Id: <20250415125200-c907d82a2ee2f431@stable.kernel.org>
X-Mailer: git-send-email 2.39.5
In-Reply-To:  <20250415103125.15782-2-zenmchen@gmail.com>
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

✅ All tests passed successfully. No issues detected.
No action required from the submitter.

The upstream commit SHA1 provided is correct: 9e1aff437a560cd72cb6a60ee33fe162b0afdaf1

WARNING: Author mismatch between patch and upstream commit:
Backport author: Zenm Chen<zenmchen@gmail.com>
Commit author: Ping-Ke Shih<pkshih@realtek.com>

Status in newer kernel trees:
6.14.y | Present (exact SHA1)
6.13.y | Present (exact SHA1)
6.12.y | Present (exact SHA1)

Note: The patch differs from the upstream commit:
---
1:  9e1aff437a560 < -:  ------------- wifi: rtw89: pci: add pre_deinit to be called after probe complete
-:  ------------- > 1:  f754c56267b24 wifi: rtw89: pci: add pre_deinit to be called after probe complete
---

Results of testing on various branches:

| Branch                    | Patch Apply | Build Test |
|---------------------------|-------------|------------|
| stable/linux-6.6.y        |  Success    |  Success   |

