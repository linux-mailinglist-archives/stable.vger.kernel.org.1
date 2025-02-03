Return-Path: <stable+bounces-112014-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 40317A25989
	for <lists+stable@lfdr.de>; Mon,  3 Feb 2025 13:37:49 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id DC2133A6B09
	for <lists+stable@lfdr.de>; Mon,  3 Feb 2025 12:37:40 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id E516B204694;
	Mon,  3 Feb 2025 12:37:45 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="ZyZpCtrT"
X-Original-To: stable@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A6086204690
	for <stable@vger.kernel.org>; Mon,  3 Feb 2025 12:37:45 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1738586265; cv=none; b=prVaPJWG/bh9y2tIDbU/tPgnkeLRrrcZJJ97ET6XqwtfJLCDEN8h2XmRPRpjMZwuc0t+Kxi9w2mKNmt58boyV2XRy2waRUcaM+GIh8N7Qj3/kWG2xaVPQq6qhNneImrFsg5ziTmBCa7y7Rc0E9wy0cFBDKhxHq8xajaBGP7G5rQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1738586265; c=relaxed/simple;
	bh=zfDzOeGRnGsa6JJ+x/er22PY2anOo5F4lADyY1aGpaA=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=VrGqBXRY9YIWC8MRLd/b3KOFcM8V4YQN/DWripuEZohi/qUSaW439V9A4RCDuBOkJnOKwyhQL0qKz2pgr+had5xFyLkBhaRr3hVFaQwYBM3/h8dySCpBYljadVdMiKR4zxOSm9mV/t8BF6B7GUeuRbNUueNBwuYy/xCqSjYkzcw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=ZyZpCtrT; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 99AA7C4CEE0;
	Mon,  3 Feb 2025 12:37:44 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1738586265;
	bh=zfDzOeGRnGsa6JJ+x/er22PY2anOo5F4lADyY1aGpaA=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=ZyZpCtrTmlKWB7wB47x8bn7e6mA0OJ8EFNsFCErPliR5NHH8y1aEpWfll9DVnEN6l
	 pi9gFzESStyKmdSfOkLLflzDFBz7j3IB2mZ6NL3DFcW1qpl/W2LCJVPa9lnlbUQASY
	 C0K4SLSkBgF/XNYGpk908axRgXO1uiPfp++e8cqHDDdRpE0v+g3I/hI+og7u44jBjg
	 vRclCLMAENh9ijuw+pvZCdBr2kJiVtxyzo8xiSIWlbzlQ3R1kbrLf2SeMdW3ff8yZs
	 f5hmVT6zDTGZoRUE+QxbBxBPoA+gCscmEnMAgEOiRbt5E4MzLsp3Rh0Cb4lcETGp+/
	 TkEV8k84UZjEg==
From: Sasha Levin <sashal@kernel.org>
To: stable@vger.kernel.org
Cc: Parth Pancholi <parth105105@gmail.com>,
	Sasha Levin <sashal@kernel.org>
Subject: Re: [PATCH v2] kbuild: switch from lz4c to lz4 for compression
Date: Mon,  3 Feb 2025 07:37:43 -0500
Message-Id: <20250203062507-d20e2fd0019e4013@stable.kernel.org>
X-Mailer: git-send-email 2.39.5
In-Reply-To:  <20241114145645.563356-1-parth105105@gmail.com>
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

Found matching upstream commit: e397a603e49cc7c7c113fad9f55a09637f290c34

WARNING: Author mismatch between patch and found commit:
Backport author: Parth Pancholi<parth105105@gmail.com>
Commit author: Parth Pancholi<parth.pancholi@toradex.com>


Status in newer kernel trees:
6.13.y | Present (exact SHA1)

Note: The patch differs from the upstream commit:
---
Failed to apply patch cleanly, falling back to interdiff...
---

Results of testing on various branches:

| Branch                    | Patch Apply | Build Test |
|---------------------------|-------------|------------|
| stable/linux-6.13.y       |  Failed     |  N/A       |
| stable/linux-6.12.y       |  Success    |  Success   |
| stable/linux-6.6.y        |  Success    |  Success   |
| stable/linux-6.1.y        |  Success    |  Success   |
| stable/linux-5.15.y       |  Failed     |  N/A       |
| stable/linux-5.10.y       |  Failed     |  N/A       |
| stable/linux-5.4.y        |  Failed     |  N/A       |

