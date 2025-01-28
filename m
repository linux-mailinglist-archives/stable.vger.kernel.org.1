Return-Path: <stable+bounces-111066-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 5207CA2154A
	for <lists+stable@lfdr.de>; Wed, 29 Jan 2025 00:49:35 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id B2C9E1640B5
	for <lists+stable@lfdr.de>; Tue, 28 Jan 2025 23:49:33 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id C058E19E97B;
	Tue, 28 Jan 2025 23:49:31 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="bURGSE0w"
X-Original-To: stable@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7CFAC5672
	for <stable@vger.kernel.org>; Tue, 28 Jan 2025 23:49:31 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1738108171; cv=none; b=d5RDbEpZG+Ek9wwL3cQdW+XTotOK6i95cr3U2kBOn4S93U6iA2lOIo0k24M6OxQO0+4Eag16/vtjTfic6q7jgOL+/pdhdep7wMylDi2ZlS2fMTov2GCLAGSBGKbWv1ngRo5XnSBCxh4sJrDjQ/I2JsI7G8sRlMK3iqUNozlW0xI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1738108171; c=relaxed/simple;
	bh=XNwYpNIzxfg5VocoOqCnw5SqfvgRa0JS4YWcnaQKmHE=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=fggmqXiIUun4+sv/Ph/ZT/xqcuMuyvQLaT2TjXnlibeep6i7Sb7tayDi8EhOBaE+GbE8bDTLAunJmbDCfXUbbIOqADIKe779eTHvkbDjCITjEkWTEmSiBlQjP6JGihdlg5bigREAKW8QsbLoWJv+LDuKlgz4nypPh1dsd/i2E4E=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=bURGSE0w; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 78A6EC4CED3;
	Tue, 28 Jan 2025 23:49:30 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1738108170;
	bh=XNwYpNIzxfg5VocoOqCnw5SqfvgRa0JS4YWcnaQKmHE=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=bURGSE0wZbAKRa7ltM8o4OU9nqzBQbFKXuDlhENZysJOlppjLGlXsxZEfhJNz6Y4g
	 v8ANSNu1tQHUzP161122Y8XhbFRAorduiJxqo0aQBND5JyPA3BmxJeRQxvJDJ3p8xS
	 7uhRBftBKRO0Obop3PZUDmmgeCzIOuS2LIihS5eKJl2Vc4Ss79yiVhXwWbZzB7mLUS
	 98Mp9kaPiJ6q1aEpwu9J84/Warir3Hq1D4uK7Bx4nbJ+tI+uolIA/Gw7ovXcXlR7+R
	 5VZ/Rmn57JCqinqqPs0NWL1U6PvIosAJZl84TwAiKMcAN0lgqmNw7M4uVCKxLLGSgo
	 zx0yev3G8fKzw==
From: Sasha Levin <sashal@kernel.org>
To: stable@vger.kernel.org
Cc: Vasiliy Kovalev <kovalev@altlinux.org>,
	Sasha Levin <sashal@kernel.org>
Subject: Re: [PATCH v3 5.10 2/2] net: defer final 'struct net' free in netns dismantle
Date: Tue, 28 Jan 2025 18:49:29 -0500
Message-Id: <20250128182939-6fd00f5083af4d6f@stable.kernel.org>
X-Mailer: git-send-email 2.39.5
In-Reply-To:  <20250128221522.21706-3-kovalev@altlinux.org>
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

The upstream commit SHA1 provided is correct: 0f6ede9fbc747e2553612271bce108f7517e7a45

WARNING: Author mismatch between patch and upstream commit:
Backport author: Vasiliy Kovalev<kovalev@altlinux.org>
Commit author: Eric Dumazet<edumazet@google.com>


Status in newer kernel trees:
6.13.y | Branch not found
6.12.y | Present (different SHA1: 6610c7f8a8d4)
6.6.y | Present (different SHA1: b7a79e51297f)
6.1.y | Present (different SHA1: 3267b254dc0a)
5.15.y | Not found
5.10.y | Not found

Note: The patch differs from the upstream commit:
---
Failed to apply patch cleanly, falling back to interdiff...
---

Results of testing on various branches:

| Branch                    | Patch Apply | Build Test |
|---------------------------|-------------|------------|
| stable/linux-5.10.y       |  Success    |  Success   |

