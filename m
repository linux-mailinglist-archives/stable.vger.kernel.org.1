Return-Path: <stable+bounces-108298-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 862FFA0A58D
	for <lists+stable@lfdr.de>; Sat, 11 Jan 2025 20:05:06 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 7FCB71882CE8
	for <lists+stable@lfdr.de>; Sat, 11 Jan 2025 19:05:09 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id C3EEF1B4237;
	Sat, 11 Jan 2025 19:05:03 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="AB0v/8wD"
X-Original-To: stable@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 818F81B0434
	for <stable@vger.kernel.org>; Sat, 11 Jan 2025 19:05:03 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1736622303; cv=none; b=hsZPwo0gvyjceH+jwESyu4uFmZ+HIjXz7t3eW+p9rQaS9U9ojLjHynYa8+jNDFkhtMlS/BQdjHf6Hhd7Qq+2Rw9VrrdPij3mFJGs7pNdcmsf1Gv4zvnkEu8ZbPBzNHLxCgiNvqlNMtShMVua2ht5lOMmH0XO4kckULsfv+dmE34=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1736622303; c=relaxed/simple;
	bh=WfV3Jso+sLZLFfF3Ui1yCgxVJmuzjPQWKs0MP8BQN60=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=sCHuqv4optlIMh5EXxK8MmCeKaOjw8ZBM3wtBGmVsJpAVD3d4/SC4mfbypKPC+HrycBVjI2Xhlit6b+jLXAXkj9FmYRWQ85SUSFchOU8tRJLZVzEJvKbWX9XUXViOIiDu+yNOrORZuDC5XtEi76ruj2xCIX0HYaPbTncTUmUB7k=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=AB0v/8wD; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 6AD50C4CED2;
	Sat, 11 Jan 2025 19:05:02 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1736622303;
	bh=WfV3Jso+sLZLFfF3Ui1yCgxVJmuzjPQWKs0MP8BQN60=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=AB0v/8wD/7Grb6QbXD9nQs63aT13iO1m8ID1ViQ4Gh1KEBxG6lMtsm3U1kKNoHBCN
	 Vs0merzNx9qANytb/JYG7Ga4TN9MuQklmynxGqHZl6sAspPL2DzEoHAw+jVZH4Yi5z
	 IVa2DaF8mI4veI3JxQv0Yta8MiI5HFRwd5MEGYv0mhKxjOETddaiOkIWBfSLSKMQ1v
	 pyJlO0pnAT22LeRZdelQ053RASY+gy2G5bnkeURp4wRLs8iI8fFSyl157+BY7ntPph
	 Of0lSjQc8uX2g3czGiM186aav6RSivjJr4C77OcNZA/a67a/ekqHVFwhNiEDl/wyE6
	 Lt2E89+XjI6kw==
From: Sasha Levin <sashal@kernel.org>
To: stable@vger.kernel.org
Cc: Dominique Martinet <dominique.martinet@atmark-techno.com>,
	Sasha Levin <sashal@kernel.org>
Subject: Re: [PATCH 5.15 2/3] zram: check comp is non-NULL before calling comp_destroy
Date: Sat, 11 Jan 2025 14:05:00 -0500
Message-Id: <20250111133643-6d5b630f544bba43@stable.kernel.org>
X-Mailer: git-send-email 2.39.5
In-Reply-To:  <20250110075844.1173719-3-dominique.martinet@atmark-techno.com>
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

No upstream commit was identified. Using temporary commit for testing.

Results of testing on various branches:

| Branch                    | Patch Apply | Build Test |
|---------------------------|-------------|------------|
| stable/linux-5.15.y       |  Success    |  Success   |

