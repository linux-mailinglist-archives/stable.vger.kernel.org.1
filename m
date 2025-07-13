Return-Path: <stable+bounces-161765-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id 73445B0312A
	for <lists+stable@lfdr.de>; Sun, 13 Jul 2025 15:30:21 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id D9A177A8ED5
	for <lists+stable@lfdr.de>; Sun, 13 Jul 2025 13:28:53 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 46226198E8C;
	Sun, 13 Jul 2025 13:30:17 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="BmmMr11p"
X-Original-To: stable@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0636E2E36E3
	for <stable@vger.kernel.org>; Sun, 13 Jul 2025 13:30:15 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1752413417; cv=none; b=A5+wyU7ZcfmyazENEXbl7A1rDN7PKYn3Gaf0j+EuSGbOdcR4lhMtI0GLDE7iNPDjBqgUom3gZsb0PQ4DwfNIaWGQ5jCKsOL5fk4Uc4Xkqi+Us9Ed1JK97ne/UsFCM/pFZ+0I6rmo13qeL3MC8sapDcuW7svsqCjFsmTRQrizjE8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1752413417; c=relaxed/simple;
	bh=0HDvXsquJe35RxC/4exG6QdLKMdNUeFZF5pNc1hetFI=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version:Content-Type; b=rWoK7yxMFr7jd9CyMldBMHPUxcU1e/51alDsi+0a+GDqAp14QVCeiknjwWszUygT3k3SdSt2S7sW+9lgAMgqMVXgk0nt14pJ5NqCGq3hBTLYjOljBEEQHE9VtkJ2j6skPwFSR0QWXk2KygiM3iGm+OXy5jTGENdrcSVhlXBPkUk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=BmmMr11p; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 105EBC4CEE3;
	Sun, 13 Jul 2025 13:30:14 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1752413415;
	bh=0HDvXsquJe35RxC/4exG6QdLKMdNUeFZF5pNc1hetFI=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=BmmMr11pBkRdrzv2aT4+tiDhsf1mDIn9yO9P6Kv8E5e2P+hFp8qILb2QtfHKeIG06
	 j3m684qf0DrkW/6c+8HrpqfIqclqXlEcX2vrvwRunK0z23xdz/EoB0Ukai8yzzGTJM
	 CVFwMdM07jB45huvT1nF8dlxWwZKhFU9fXjT+ZSmh9t7E7c+kxlIotxpQzsGjk4Sjf
	 OpHpkc1q1xDFzJiKFoMBxZjGEepX4b+bJ2fqUK+ofAcS4UHNGN5FZUfINYbngelNst
	 fThSYjS9ss7moFkg+ACSnHeG2e51tfAutvbitWEu19VZZqnaCwxJraU73nVg7aEqJY
	 Zz6Ep7JZYL8sg==
From: Sasha Levin <sashal@kernel.org>
To: stable@vger.kernel.org,
	bp@alien8.de
Cc: Sasha Levin <sashal@kernel.org>
Subject: Re: [PATCH 6.6-stable] x86/CPU/AMD: Properly check the TSA microcode
Date: Sun, 13 Jul 2025 09:30:12 -0400
Message-Id: <20250712204011-bc5d32a123e62268@stable.kernel.org>
X-Mailer: git-send-email 2.39.5
In-Reply-To:  <20250711192358.GJaHFkzpM1GPcNQz6v@fat_crate.local>
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
⚠️ Could not find matching upstream commit

No upstream commit was identified. Using temporary commit for testing.

Results of testing on various branches:

| Branch                    | Patch Apply | Build Test |
|---------------------------|-------------|------------|
| stable/linux-6.6.y        |  Success    |  Success   |

