Return-Path: <stable+bounces-100477-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 94AD29EBA15
	for <lists+stable@lfdr.de>; Tue, 10 Dec 2024 20:25:09 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 3591B1888934
	for <lists+stable@lfdr.de>; Tue, 10 Dec 2024 19:25:08 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id E679521423A;
	Tue, 10 Dec 2024 19:25:02 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="mrPmI9X+"
X-Original-To: stable@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A6B1B214227
	for <stable@vger.kernel.org>; Tue, 10 Dec 2024 19:25:02 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1733858702; cv=none; b=X+AOK3LagS53+m86Xj+/wzlKIHd45Eq1I7gw/vVbc9RYV6xvtJ6f1nxlOohWVWwMZ/gqcwQa7i8jn0+D2QSIDZ9n0fk3sIFUmO/suKDAyGSL0ojkSGRNsy0BuqrhO2DUt2ARJDT0TpNesrlTQcljt2u8XRiiZy/HhQdfAxAj0R4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1733858702; c=relaxed/simple;
	bh=uI9do9fLMcVzHJ4egFdHqh9qsp0PK0cZ8/lnDQZimYU=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=CYzsO2w/f+Xd7Z0VZhlbxsfl2dXi20kROxI1TUd9w9Keh9bCBjIRQqStuHI7IGsr7LbISuXnNx8s3Dv8nNyuJk6n/K7Vx2W28I+xCohBS7r/kJyraiGgb9+XjOQqt9OqySOzkSCnDEBvoSwYxLhPmeOq7L9JhCTBkkQlnVFTE08=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=mrPmI9X+; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id AB852C4CEDF;
	Tue, 10 Dec 2024 19:25:01 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1733858702;
	bh=uI9do9fLMcVzHJ4egFdHqh9qsp0PK0cZ8/lnDQZimYU=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=mrPmI9X+wZyKj2U8DFBxoc5R8aVyKrziDmzZoryLdGLpioi1HAC/w50cfM0Xmz0HI
	 AIZpQuXLho+rdXdEcbQB/rv//Zo6X4O3H8hKawRmch9AJ0rI8X7vFTRBZsBVtP3Ja1
	 RM/KwVF8wFMaY9EroEI9Sw53Lro/nKXziFZQ/IBHt0reoi0e/2R5QROZ/CeO3xk+fK
	 0umXqL/CAT6zbrb+EBA7Kfc6Q6c7fQ1pKGNHKr2U7QT0rQlwzA5YIaG8hw7/AkQaao
	 qhNsFY4eNnL8D5TJIEbE5iXzbcOFArNs+lxto+bcHJf0IpafekAYmE00g33Ayca+kT
	 2eCrH8OlaFuXw==
From: Sasha Levin <sashal@kernel.org>
To: stable@vger.kernel.org
Cc: Sergey Senozhatsky <senozhatsky@chromium.org>,
	Sasha Levin <sashal@kernel.org>
Subject: Re: [PATCH 5.15.y] modpost: Add .irqentry.text to OTHER_SECTIONS
Date: Tue, 10 Dec 2024 14:25:00 -0500
Message-ID: <20241210090621-8ee51ba3e94f4064@stable.kernel.org>
X-Mailer: git-send-email 2.43.0
In-Reply-To:  <20241210111048.1895398-1-senozhatsky@chromium.org>
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

Note: The patch differs from the upstream commit:
---
1:  7912405643a14 < -:  ------------- modpost: Add .irqentry.text to OTHER_SECTIONS
-:  ------------- > 1:  72c29e57a175e modpost: Add .irqentry.text to OTHER_SECTIONS
---

Results of testing on various branches:

| Branch                    | Patch Apply | Build Test |
|---------------------------|-------------|------------|
| stable/linux-5.15.y       |  Success    |  Success   |

