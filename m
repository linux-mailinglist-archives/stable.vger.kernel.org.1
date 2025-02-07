Return-Path: <stable+bounces-114335-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 65E54A2D100
	for <lists+stable@lfdr.de>; Fri,  7 Feb 2025 23:51:22 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 7FA1F3AA827
	for <lists+stable@lfdr.de>; Fri,  7 Feb 2025 22:51:13 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 7C2211C5F1D;
	Fri,  7 Feb 2025 22:51:19 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="egjcnJsU"
X-Original-To: stable@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3BC691AF0AF
	for <stable@vger.kernel.org>; Fri,  7 Feb 2025 22:51:19 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1738968679; cv=none; b=QJVnQ1Z01sM3CDhXcP4u31dB7AN/DJXV8cCCRkR+SyUDQzkevdPs1WjrWslcy3s9WgxgU1SkD5iEPhSvtBQjDvu8TYkKUm+AuFqBueRKk3KCYqB24rtinaVr4m5OEcRzhS2ouYIn/aW9v7uISop576Kcb864ZZaaXh2dmodpawA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1738968679; c=relaxed/simple;
	bh=dSDjmCzUtBrf3nrwZIdD4gkMBQlXgjWoVuRgjtwWtAY=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=mH1AreOaixvxzeH5Co1u/+dWBYV7cNdrPNo4bfJyNrI1zEe3sMfaEmFLKv3osfNCxriJNH4WkKi6gm0l94Qs51vcEUoM83g45PWJo54x4rksufOO8FLUVGdwpQ7i9evuV6m5xcr8ClzEILSpxXLci0y9idjWN4tpzkRTJlfXOqs=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=egjcnJsU; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id A2565C4CED1;
	Fri,  7 Feb 2025 22:51:18 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1738968679;
	bh=dSDjmCzUtBrf3nrwZIdD4gkMBQlXgjWoVuRgjtwWtAY=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=egjcnJsUOjlopd9en6FU+75SDdbOTelUROkgeUJDTnhE/+cwnMWoV5zU/IRP6vHEr
	 yAUPqUwQXK5Uh+zwmNSZtLXJeQo0xquvGlF04sF3rGUyXN8DBlCxU0YmI32eZsu3JX
	 7TA4SVyEwJE/6Rogl1bx6ranWAFcQHQRIMAqJtS2K2bTv9wCjMlGgN49ReHs9eK/s/
	 OREyDInd9kPHHBrxpeqRaRilMZjUt1K9o4cd5TI96EC9BuCsARPwDaIUbNuSBIQOCC
	 DlfYfQszOkJeJLdbZFsSeLgvywq2K9zclxIW3TOEStqh7xmrg0jdDwRvvoZKTP2KL6
	 +GB0xq7nFfz5g==
From: Sasha Levin <sashal@kernel.org>
To: stable@vger.kernel.org
Cc: Koichiro Den <koichiro.den@canonical.com>,
	Sasha Levin <sashal@kernel.org>
Subject: Re: [PATCH 6.6 1/2] Revert "btrfs: avoid monopolizing a core when activating a swap file"
Date: Fri,  7 Feb 2025 17:51:17 -0500
Message-Id: <20250207170032-8d49f01f5702998c@stable.kernel.org>
X-Mailer: git-send-email 2.39.5
In-Reply-To:  <20250206162131.1387235-1-koichiro.den@canonical.com>
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

No upstream commit was identified. Using temporary commit for testing.

Results of testing on various branches:

| Branch                    | Patch Apply | Build Test |
|---------------------------|-------------|------------|
| stable/linux-6.6.y        |  Success    |  Failed    |
| stable/linux-6.1.y        |  Success    |  Failed    |

Build Errors:
Build error for stable/linux-6.6.y:
    ssh: connect to host 192.168.1.58 port 22: No route to host=0D

Build error for stable/linux-6.1.y:
    ssh: connect to host 192.168.1.58 port 22: No route to host=0D

