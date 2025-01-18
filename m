Return-Path: <stable+bounces-109463-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id EDD0EA15EA4
	for <lists+stable@lfdr.de>; Sat, 18 Jan 2025 20:41:09 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 2CC237A1F93
	for <lists+stable@lfdr.de>; Sat, 18 Jan 2025 19:40:59 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 1971D1B7F4;
	Sat, 18 Jan 2025 19:41:04 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="erZAklHZ"
X-Original-To: stable@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id CA8EB1F94C
	for <stable@vger.kernel.org>; Sat, 18 Jan 2025 19:41:03 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1737229263; cv=none; b=rbijCwg2Q9P79f0OrPpSh5ivmj+ddr+UZDISQmIeq73HWJaRYLnlRK2UjgUgPVeUe16IoVhVRybJzTmAxWbkrTN3a3c/ADAXNQKwyLq+tthp56Ql9RPrfx8O15SVFW2mwOb8lmbK1R400SqymNOdCwzyEjGIAqF5MfP8jknKYno=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1737229263; c=relaxed/simple;
	bh=fMGLfDMr4H+Zqgg/99LWVIzC3libIUEacs8wrn/U+IE=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=CKhIfepO4TFfKlti/rSUIu6zMNYkSRx0AWo56tKFXD8CEDH3Mdl3hN0U677wNeKXkJ5HIg246B3NQ6nRKHDkB5q6PiTAHVBEmWI4EQOXTRcQtf5xyoxjbPVHtARDuFBerGTLcqAqWDHT/K4tBelzI0jWJCFIEPkn4G5Aintz31A=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=erZAklHZ; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id CE726C4CED1;
	Sat, 18 Jan 2025 19:41:02 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1737229263;
	bh=fMGLfDMr4H+Zqgg/99LWVIzC3libIUEacs8wrn/U+IE=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=erZAklHZuhWkcCRTOwCWEZMe8A23PZvm2qcvj9hhhBPR3niyPH568y1VEamm3Ye/M
	 TPFMm7f8tQqqQCWVgFyn8Hhz59UagFNGyZS/OqxV/ZB7z87prsKsKU5ArTDce8K3QL
	 b6dNK0I/zlEAwwVuax1XtVONuQopMAAE6OIpfss9uzZY09BLi5+oKm0LCsV1rv7IL3
	 EercGoqrvf/geIhDEU9SbqvbnBD4eYfialnlAql4PJ9XQP7gMe7Yd1lvuNR3g93nUs
	 5ETPS/mT9J18HyijUre1CiTKyXZ8IzvCOYPzVI645XtTrAJ2mk9xvZ0pG3y0exfW29
	 7ST4ySr5hK/hw==
From: Sasha Levin <sashal@kernel.org>
To: stable@vger.kernel.org
Cc: Vasiliy Kovalev <kovalev@altlinux.org>,
	Sasha Levin <sashal@kernel.org>
Subject: Re: [PATCH 6.1] fscache: delete fscache_cookie_lru_timer when fscache exits to avoid UAF
Date: Sat, 18 Jan 2025 14:41:01 -0500
Message-Id: <20250118140309-f1746723bb0f366d@stable.kernel.org>
X-Mailer: git-send-email 2.39.5
In-Reply-To:  <20250118165349.472773-1-kovalev@altlinux.org>
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

The upstream commit SHA1 provided is correct: 72a6e22c604c95ddb3b10b5d3bb85b6ff4dbc34f

WARNING: Author mismatch between patch and upstream commit:
Backport author: Vasiliy Kovalev<kovalev@altlinux.org>
Commit author: Baokun Li<libaokun1@huawei.com>


Status in newer kernel trees:
6.12.y | Present (exact SHA1)
6.6.y | Present (different SHA1: e0d724932ad1)
6.1.y | Not found

Note: The patch differs from the upstream commit:
---
1:  72a6e22c604c9 < -:  ------------- fscache: delete fscache_cookie_lru_timer when fscache exits to avoid UAF
-:  ------------- > 1:  632168ef85f1f fscache: delete fscache_cookie_lru_timer when fscache exits to avoid UAF
---

Results of testing on various branches:

| Branch                    | Patch Apply | Build Test |
|---------------------------|-------------|------------|
| stable/linux-6.1.y        |  Success    |  Success   |

