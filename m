Return-Path: <stable+bounces-163311-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 60CFDB09933
	for <lists+stable@lfdr.de>; Fri, 18 Jul 2025 03:34:35 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id E9D91561BB2
	for <lists+stable@lfdr.de>; Fri, 18 Jul 2025 01:34:33 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 4152D17C220;
	Fri, 18 Jul 2025 01:34:31 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="oYfeTp13"
X-Original-To: stable@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id EAF99153BD9
	for <stable@vger.kernel.org>; Fri, 18 Jul 2025 01:34:30 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1752802471; cv=none; b=RBDn2hN3GxKG9z88rErGHpUP6dTI3JoozYhZV7OMwzMTO1AxNzUX4dzFPNu4YT14h+ZLKnMqZYQrwgZeLfxB5Q9Vs5eJTX5jr9UKb9DCkuBOc/l4QlOY6BbpACFRVlUPdy6P+7cf/QmKvHv0WgaLzpyOwpe6XfMfOnEM2fyup5w=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1752802471; c=relaxed/simple;
	bh=0oXCvbS70boowkDDWJqt+/mfmAUYUy+AFnNw4yWGFls=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version:Content-Type; b=VSGazDO4YAXFfHzWStcJpEgRzWJ4aE53faLXKK5VkiDdOkByraLPL2dYaMJLE8giQR7Gvaxop600t1O4LbmJ3rPyOodzN++L9ScOdDI0UUD0bC8sX2JXDfY0VWAW9LPPYcnURB8DcuF3mwz7s/rBMOSgUktn50ODlShx2kq8bYY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=oYfeTp13; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 011FDC4CEE3;
	Fri, 18 Jul 2025 01:34:29 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1752802470;
	bh=0oXCvbS70boowkDDWJqt+/mfmAUYUy+AFnNw4yWGFls=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=oYfeTp13pZvGiEFtkx3DybVHbo/W8AQqZrLet4PgT3GoWqIv5E+lchL2intJFuGRP
	 3ZoIl0a1/+9fn0Z/DTYnXSTwNgg3khEB0NTVMriZvQx5cPxwOj3TEcCLqRuWiB6Pws
	 WNejfGABGTLKEbS0V/08Hr8l891HRzib+5+LM0ERVKf/kkNQnTJM2CIDu7wO9kS88l
	 zOJDGtg/85kvqRbFesipq+ZEb6rvsSPeqaJ1nLHm3JLjXdRhmdInMJIjG2lijoKgoa
	 1OefJxl5XvwNEN2V3E4FFzuw1Af/P9FCWc8kq1ei3uJq/E6OmN3zDkGLw22ovVQa6J
	 0dDsGWIyr2aJw==
From: Sasha Levin <sashal@kernel.org>
To: stable@vger.kernel.org
Cc: Sasha Levin <sashal@kernel.org>
Subject: Re: [PATCH 5.4.y 6/6] net_sched: sch_sfq: reject invalid perturb period
Date: Thu, 17 Jul 2025 21:34:28 -0400
Message-Id: <1752797234-42b057ec@stable.kernel.org>
X-Mailer: git-send-email 2.39.5
In-Reply-To: <20250717124556.589696-7-harshit.m.mogalapalli@oracle.com>
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

The upstream commit SHA1 provided is correct: 7ca52541c05c832d32b112274f81a985101f9ba8

WARNING: Author mismatch between patch and upstream commit:
Backport author: Harshit Mogalapalli <harshit.m.mogalapalli@oracle.com>
Commit author: Eric Dumazet <edumazet@google.com>

Results of testing on various branches:

| Branch                    | Patch Apply | Build Test |
|---------------------------|-------------|------------|
| 5.4                       | Success     | Success    |

