Return-Path: <stable+bounces-106111-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 005509FC753
	for <lists+stable@lfdr.de>; Thu, 26 Dec 2024 02:22:06 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 0B9AD161CCE
	for <lists+stable@lfdr.de>; Thu, 26 Dec 2024 01:21:46 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id AB962EEA6;
	Thu, 26 Dec 2024 01:21:44 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="DuaF4tYa"
X-Original-To: stable@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6B57714A91
	for <stable@vger.kernel.org>; Thu, 26 Dec 2024 01:21:44 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1735176104; cv=none; b=gF+AVDBWBFxQKON/peUI/lET6y07WI3ZOfugswHK0TibIXGjsYpFct9J1mBM0VkWGDn8xDCY8n0cDDrxKbtsRfPtZmMwDkf2wzisUPQAtQ1NExPV2PBYpwnzUH7Xm2ZquyC7OuUZt748Le7bg9u8/A7ih18+JLb05SMl/tuaVAQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1735176104; c=relaxed/simple;
	bh=uj5tpZMDAWY4Bf8MrGRUgaYVr1G0gmOVdq9V1ZEHPsk=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=jaRkjWo3jJPCuknIqvfMqUHA2BWQXXsKvJbgXr4JlKSECjAE2+E+tdxvOV4F4rbW7m2JQY4gE+csmQSXfbitqcqUbVyHMkUvKVUpDyZMx+We4rY32js9JcDLMPuiPGLJtAzUxuykCpL69n0kKhjcEDEgFH51VcMwMhAi89Sjq58=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=DuaF4tYa; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 8ED2BC4CECD;
	Thu, 26 Dec 2024 01:21:43 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1735176104;
	bh=uj5tpZMDAWY4Bf8MrGRUgaYVr1G0gmOVdq9V1ZEHPsk=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=DuaF4tYagcZAfJtaczhyLjSHqAbKPrhaEsOmR5MJ08eAwSacoLw+oHqvH3WRmRSLX
	 y39qnu0JNs5Pkct6s32Pe4634XluQbA3SO8doQXkMclObCZeBk+a/8CvlRq/CjSl2i
	 Rbh0UGmAfeIk3eE6y2686PzR0OOOB7NrOiIkqJbpHUqsN9TSqlZFgh4K1ik+SZ7lRf
	 ZmacDg1Brwr9J6HPf0WAXEjXg2WWtrfLTU9gH6rHYGkwfazigeO2yN6fOE4uwvwr+s
	 euxUpnSd3xzp5OVMym6b2Zx1ACjUS1CaxO1IQtQ6FyAQDwDwC8ZD3i3UcIVDhm7XuJ
	 avv4l0WLmPapQ==
From: Sasha Levin <sashal@kernel.org>
To: stable@vger.kernel.org
Cc: "Matthew Wilcox (Oracle)" <willy@infradead.org>,
	Sasha Levin <sashal@kernel.org>
Subject: Re: [PATCH 5.15.y] vmalloc: fix accounting with i915
Date: Wed, 25 Dec 2024 20:21:42 -0500
Message-Id: <20241225174930-df8763d4798dc0e8@stable.kernel.org>
X-Mailer: git-send-email 2.39.5
In-Reply-To:  <20241223201800.4009725-1-willy@infradead.org>
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

Found matching upstream commit: a2e740e216f5bf49ccb83b6d490c72a340558a43

WARNING: Author mismatch between patch and found commit:
Backport author: "Matthew Wilcox (Oracle)" <willy@infradead.org>
Commit author: Matthew Wilcox (Oracle) <willy@infradead.org>


Status in newer kernel trees:
6.12.y | Not found
6.6.y | Not found
6.1.y | Not found
5.15.y | Not found

Note: The patch differs from the upstream commit:
---
1:  a2e740e216f5 < -:  ------------ vmalloc: fix accounting with i915
-:  ------------ > 1:  8669df66946c vmalloc: fix accounting with i915
---

Results of testing on various branches:

| Branch                    | Patch Apply | Build Test |
|---------------------------|-------------|------------|
| stable/linux-5.15.y       |  Success    |  Success   |

