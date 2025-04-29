Return-Path: <stable+bounces-137087-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 5FA5AAA0C98
	for <lists+stable@lfdr.de>; Tue, 29 Apr 2025 15:02:21 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 8FCC54853CF
	for <lists+stable@lfdr.de>; Tue, 29 Apr 2025 13:02:03 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 4BA0527452;
	Tue, 29 Apr 2025 13:01:03 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="hFQIEsl9"
X-Original-To: stable@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 07E608F54
	for <stable@vger.kernel.org>; Tue, 29 Apr 2025 13:01:03 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1745931663; cv=none; b=PtaRPlPW5jfwu3VYALVzkBDpyZcDhdzGQYZ3BmGp9JFsWEXK23vw/yiWUdN2TURp0gzy/VT9Ia/xloPVCrgB1+VKZSqRMi0li3OttMyTys3Z7soMiujS/NAQWRlGNMDNQnN8X8LDqKXGgntxL7aW0+TIzvkLsCV6tFg6yXMWsiE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1745931663; c=relaxed/simple;
	bh=74ri7q5Ri84nXCLTLOj3goxv2CqbUrhlx6616Q1TAGc=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version:Content-Type; b=NUdxIScj4cCdT+cXXTKJHVjGujIEQ6BueaJrW8euj0imcUVYVR1LPjfDSBhotFunv8O+ho9ibg2bFZ73DVDVTBv4vD1L2YOzxlRmjcEQ8uFm+5xtsVsfgXWlvDruWwoJUd7IBIqPgmbcLN5GC9okeIzZzoWhmKU744+ItlQ79LI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=hFQIEsl9; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 6DECFC4CEE3;
	Tue, 29 Apr 2025 13:01:02 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1745931662;
	bh=74ri7q5Ri84nXCLTLOj3goxv2CqbUrhlx6616Q1TAGc=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=hFQIEsl9Pmhsx1S0wPMNkdY56rQnC2nytmemqa4ZrmPD4dlhKpMskCorVcw6VnUjZ
	 uwwiceWqa4u1Q3xpIv1upzcbQZLquoJkrWaZvpdrzzT+c0SqsUha4YLUdS+KBpDKZP
	 x3lRmH/Z7ZApSdQlhK4bnXz2iBPHar+NqDQwKe8QpBA/u8zHLivBynU7plP5RpNh38
	 D5jAlttZuuOsq1lIPl3Feks5to3V1ffViohiJ2RLFXs0+SM6biaOwTD9HOfSF+LAeN
	 TZITtvqV/rk0aqr1vun/dnPNU1yzlq54ePutxyKAZq3i7wTp2dRxOHZyYgwrJrR56K
	 hLv800vO5OdYg==
From: Sasha Levin <sashal@kernel.org>
To: stable@vger.kernel.org
Cc: =?UTF-8?q?Marek=20Beh=C3=BAn?= <kabel@kernel.org>,
	Sasha Levin <sashal@kernel.org>
Subject: Re: [PATCH 6.6.y 4/4] net: dsa: mv88e6xxx: enable STU methods for 6320 family
Date: Tue, 29 Apr 2025 09:00:58 -0400
Message-Id: <20250429005744-05bbd8510f5ecdf7@stable.kernel.org>
X-Mailer: git-send-email 2.39.5
In-Reply-To:  <20250428081854.3641-4-kabel@kernel.org>
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

The upstream commit SHA1 provided is correct: 1428a6109b20e356188c3fb027bdb7998cc2fb98

Status in newer kernel trees:
6.14.y | Present (different SHA1: 1864c8b85c76)
6.12.y | Not found

Note: The patch differs from the upstream commit:
---
1:  1428a6109b20e < -:  ------------- net: dsa: mv88e6xxx: enable STU methods for 6320 family
-:  ------------- > 1:  862fb7fac2f74 net: dsa: mv88e6xxx: enable .port_set_policy() for 6320 family
---

Results of testing on various branches:

| Branch                    | Patch Apply | Build Test |
|---------------------------|-------------|------------|
| stable/linux-6.12.y       |  Success    |  Success   |

