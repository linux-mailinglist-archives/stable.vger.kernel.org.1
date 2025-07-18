Return-Path: <stable+bounces-163312-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id D4958B09935
	for <lists+stable@lfdr.de>; Fri, 18 Jul 2025 03:34:35 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id DB9F9176B19
	for <lists+stable@lfdr.de>; Fri, 18 Jul 2025 01:34:35 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 377EF3398B;
	Fri, 18 Jul 2025 01:34:34 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="MwV5vPu4"
X-Original-To: stable@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E9BD82C187
	for <stable@vger.kernel.org>; Fri, 18 Jul 2025 01:34:33 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1752802474; cv=none; b=pDvaw4aC412dDaFM7BmINtDaNDieT+JRwIok4Jna9Y07xpjB4eEodiJ/F1PU3TTDCFHOAum/LQBoqzo9mwK+oKm2phAHFf1lY/AJS/dljKbPWOWF3QnEZNGGLNYIalMdgYchn0TfTd+iRHUDta6cp4H9F64QyQ+y8F8dC1mJqvo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1752802474; c=relaxed/simple;
	bh=HcM+RXMzcA2SJ6Nqstb8uIvY+FzqyD9zskkKIR7eFY8=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version:Content-Type; b=FgdqiSEU4TDliCsdBdN/SXHiR3OoHGrV+cCE4JStWdWSb30UUZzy67giwyo43KLP9ntcwC687oMI9ahG926UOLgXzHVtx39pK49KBbM/kV7eVZeG9DiO7s2+y0r5aNa5M6jPmDRgTTMSjCTE3Dhso2BtMtD5oorotW9KxKXIeSo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=MwV5vPu4; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 0A905C4CEE3;
	Fri, 18 Jul 2025 01:34:32 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1752802473;
	bh=HcM+RXMzcA2SJ6Nqstb8uIvY+FzqyD9zskkKIR7eFY8=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=MwV5vPu4Wd1MJpminiT/KsQGV6hRudf9zFGEDmRBut20hhFkeidWH7kKSKdnxS+jq
	 I4WDuAgJjEimFafDzDKgfZBSZn8pyW7atetwVPiPU1dm+0840gSu30FEguM+i41qZ+
	 k4l5jpqly4+i3h/+FsglQ6sGyuLbf7qeQc78uz1otGxCeCvAUbjbnmILHDis0+HLC8
	 Rx3OpGl3S+9YNC2Fc3MMbz1lwTWbdaK9gkuMfYlSbwTEGqq3o4iYS7dzn2I+FAS4fe
	 jfFxAh7XAWto1DAj6uDPDCm+nFTlxsXoM3+G2jDDzl2Kx5OPnzM/0CR4RUYHDcw6gL
	 Dh2U2k+iQryKA==
From: Sasha Levin <sashal@kernel.org>
To: stable@vger.kernel.org
Cc: Sasha Levin <sashal@kernel.org>
Subject: Re: [PATCH 5.4.y 2/6] net_sched: sch_sfq: handle bigger packets
Date: Thu, 17 Jul 2025 21:34:30 -0400
Message-Id: <1752797234-97c617e8@stable.kernel.org>
X-Mailer: git-send-email 2.39.5
In-Reply-To: <20250717124556.589696-3-harshit.m.mogalapalli@oracle.com>
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

The upstream commit SHA1 provided is correct: e4650d7ae4252f67e997a632adfae0dd74d3a99a

WARNING: Author mismatch between patch and upstream commit:
Backport author: Harshit Mogalapalli <harshit.m.mogalapalli@oracle.com>
Commit author: Eric Dumazet <edumazet@google.com>

Results of testing on various branches:

| Branch                    | Patch Apply | Build Test |
|---------------------------|-------------|------------|
| 5.4                       | Success     | Success    |

