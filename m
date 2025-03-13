Return-Path: <stable+bounces-124227-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 10BC6A5EEBE
	for <lists+stable@lfdr.de>; Thu, 13 Mar 2025 10:01:34 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 53B1D167AD1
	for <lists+stable@lfdr.de>; Thu, 13 Mar 2025 09:01:33 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id AFB0F26388E;
	Thu, 13 Mar 2025 09:01:22 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="DRLeJLyd"
X-Original-To: stable@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 66CEA260A3C
	for <stable@vger.kernel.org>; Thu, 13 Mar 2025 09:01:21 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1741856482; cv=none; b=WHmVhZ4KoRT7S622tc/F0IvF+U+VRiUBQ+PSzi2w9fkF00vuVjZbSP2CLNLwy5A7UR0WhCKQA+MdkCCdg5siYsqvHzdKWhqFAB4p6UYKBFvTOBQIa2FQW3B20gmCCodKsywUxTwPM0fudBahIxmyF98ScFjY1zGMkgjqjIYtg1s=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1741856482; c=relaxed/simple;
	bh=y/vA11JFb1qH/EpzmwlTMOBRSH/VeYRoaghAQKWLEso=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version:Content-Type; b=tlSrEime5XHu/lDlG7W+Yw/srn0dzRZW1EbdVmWjyU24pHq6X25/6aryXGqiLCJcXwf4CfUQRRODWQ3ZXWzQHYlWf8K7a7a5tlp+IDpNguUxhdMyiV3gD9dSI9tqkcA54acmJrEkRVrSSWWSz2+DQ0E66nkvkzdr4cSMsS74QGA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=DRLeJLyd; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 2F9EEC4CEEB;
	Thu, 13 Mar 2025 09:01:21 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1741856481;
	bh=y/vA11JFb1qH/EpzmwlTMOBRSH/VeYRoaghAQKWLEso=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=DRLeJLydoC6EblxaNOUg46msxqwfy8Rd0t8odQIQJSBtrcjupsBehNjKX+nf4E4AL
	 OTOu40PDCS3H23+TTSMr9jFGdTFzt4c0gjowneOaGgI24BU7AkS1LZeV4rfRPCmBjq
	 spVOtWFLz2sYt2kYGsx7L875JeX0hhwdgWJ7VQydiUaw6pqRNHD3hbV2FWo27T0BTc
	 ee2jBvdG64aUHg3RZ8zPYJDF86gV3xj1YZeDLfEK118movM6OxWgwF4fT2zxmdYxdE
	 rJzhbZRA13Lfg7u8S3P+h4hYRFbL6/wbyhLqWTMCqEZSKGEtM6gMFBubwAwB9RX7VR
	 R534NznmyA0iQ==
From: Sasha Levin <sashal@kernel.org>
To: stable@vger.kernel.org,
	magali.lemes@canonical.com
Cc: Sasha Levin <sashal@kernel.org>
Subject: Re: [PATCH 5.4 1/4] Revert "sctp: sysctl: cookie_hmac_alg: avoid using current->nsproxy"
Date: Thu, 13 Mar 2025 05:01:19 -0400
Message-Id: <20250312234106-1b99d59833f5cf57@stable.kernel.org>
X-Mailer: git-send-email 2.39.5
In-Reply-To:  <20250311185427.1070104-2-magali.lemes@canonical.com>
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
| stable/linux-5.4.y        |  Success    |  Success   |

