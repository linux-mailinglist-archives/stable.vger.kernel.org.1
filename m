Return-Path: <stable+bounces-119536-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id B6136A445A8
	for <lists+stable@lfdr.de>; Tue, 25 Feb 2025 17:16:31 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 89896188BB12
	for <lists+stable@lfdr.de>; Tue, 25 Feb 2025 16:14:09 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 5ACE218DB0C;
	Tue, 25 Feb 2025 16:13:52 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="SeKOgGdu"
X-Original-To: stable@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1B4621632FE
	for <stable@vger.kernel.org>; Tue, 25 Feb 2025 16:13:51 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1740500032; cv=none; b=SUbF1Gxmsq2RQJ+YfOwn4hqnvCizj+6IUtksT6qN+xxU5jfO6ORAnUMF7/9BroYLhOAG+qanaUsrwaa/qaGtm8sEhXHD1STVldEqMxYerzixbV8+Hdg6EWnTdg3nltjqagdz1Crdmua3ORwIJDUs9ucGMKxs/pso06wtCJA6TF0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1740500032; c=relaxed/simple;
	bh=ruc+7O9yU3bLZPhyZcextvitMqGgp7xKqmlRIDJrBl4=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version:Content-Type; b=GwAMLiUEySm8r/apq1u4tBio+/lqrch2w033uV+7dfJtj65NtQomahfcN+d9cQnT63OZe9lmly4cWZAKchgWPkfwJSopDZtFLHAII+x7A96LDucoeiZrghLcQRm+wYLFav3PLzLm5KfyBHNpfYs59VrAJxYnL6hsTLbRnXdClME=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=SeKOgGdu; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 52954C4CEDD;
	Tue, 25 Feb 2025 16:13:51 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1740500031;
	bh=ruc+7O9yU3bLZPhyZcextvitMqGgp7xKqmlRIDJrBl4=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=SeKOgGdu90GhPqrpekVX3u+NLjNE/OjVSUx0Qqv9crE7Uzx0Y2etbcCMEhPMz7rY8
	 K9emM9khFIuTXYYcxZmtoucSyX3cBsGGJq8UpvViwjO7qztbsHChWLlfxEaay6FLSl
	 RSGSsr64YpRV5XmyNqLLUjFZtNfNTSVKZ8Fi5GtRgdamyhAH2MC0KUNXv14Nib1Sfu
	 i8xHrX1vmeyjJgjxJms/gzzzoo48kH7DcLLySxH+tBGtc4bd3BMweRsWB9rRrojxQQ
	 PD+If/6avVu2KRMz8ewpgWlSFM16GX1qE0EWpPvLfHbO3mQsLUQ9m5Aj/DI9MZ9sCu
	 FLlJcIO3/nJSw==
From: Sasha Levin <sashal@kernel.org>
To: stable@vger.kernel.org,
	benh@debian.org
Cc: Sasha Levin <sashal@kernel.org>
Subject: Re: [PATCH 5.4,5.10 2/2] udf: Fix use of check_add_overflow() with mixed type arguments
Date: Tue, 25 Feb 2025 11:13:50 -0500
Message-Id: <20250225105119-0b2c831a88452e74@stable.kernel.org>
X-Mailer: git-send-email 2.39.5
In-Reply-To:  <Z7yXm_Vo1Y0Gjx_X@decadent.org.uk>
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
ℹ️ This is part 2/2 of a series
⚠️ Could not find matching upstream commit

No upstream commit was identified. Using temporary commit for testing.

NOTE: These results are for this patch alone. Full series testing will be
performed when all parts are received.

Results of testing on various branches:

| Branch                    | Patch Apply | Build Test |
|---------------------------|-------------|------------|
| stable/linux-5.4.y        |  Success    |  Success   |
| stable/linux-5.10.y       |  Success    |  Success   |

