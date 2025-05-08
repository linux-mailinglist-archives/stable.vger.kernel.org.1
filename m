Return-Path: <stable+bounces-142901-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 0F732AB0030
	for <lists+stable@lfdr.de>; Thu,  8 May 2025 18:19:49 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 880804E3B5F
	for <lists+stable@lfdr.de>; Thu,  8 May 2025 16:19:49 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 3224827F4E5;
	Thu,  8 May 2025 16:19:45 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="MzGEAgwP"
X-Original-To: stable@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E391722422D
	for <stable@vger.kernel.org>; Thu,  8 May 2025 16:19:43 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1746721185; cv=none; b=FjhWF2vuP2bqvPQSC1+Zy77QTIcx7JEras2hVDrxz6oflGC4GDjTe3TLTiBX3Y3N4gW2yyDfwDwteIQEY2yNpL9hwFthF8zZ81WklXFSSIhlaD5d6EUcwO6FpPBMfjGh2tloSK6ezRTzNdbmqyTt7OYt30z9Mu044LNcBmm9rHA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1746721185; c=relaxed/simple;
	bh=ULhnviXSRHg4TECSFY7lt5+RqN5h1cpbBecKaOJkA6E=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version:Content-Type; b=sVBedxf+zyETO5wOjgm/zcCOqofblXqsChsOADq+iJLjw+JrEPwAZ5UoHdEZ8hzGpFbVF7VhJoqlN03HTFPCeF9JTCWIqu0pPmf1Y+Zf+c7nLPY5qpMmmyylS7pnfsla8R8v0Jca2HkL3VaJEeKAXvmpl2O2qXlpR4weReZTOEY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=MzGEAgwP; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id D5859C4CEE7;
	Thu,  8 May 2025 16:19:42 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1746721183;
	bh=ULhnviXSRHg4TECSFY7lt5+RqN5h1cpbBecKaOJkA6E=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=MzGEAgwPEzSqNKOJg0/7xLteQvkg5TS9++OgwDVE0S/3Sq3gO9tLJJdHRFl+wT3lT
	 GP8D9fKx7TVnTUAHMC/muZltT2SomclwFACix6lLD7q+1UUP3jCkRnoJAYLrqFGIEI
	 I+59zVmoN171Jh/qP8ShbOWbUgS2KZ0zsaHNCPjj/n3H3WMB+Cw3KelqOz+1ZXIOEY
	 Hbj7pLT8g6difPOeELlqYq1EtySTboalryu8p/41j8kOb0LOBupfk7N9qYM1Bw+UBL
	 PF44UThnHqZEz1+uUAFQVeMRjyyCETfnyBwCZTv2s855CV5oNQI4ki6yW5qTPnBLgO
	 vDHk26bvBqHgg==
From: Sasha Levin <sashal@kernel.org>
To: stable@vger.kernel.org,
	jacek.lawrynowicz@linux.intel.com
Cc: Sasha Levin <sashal@kernel.org>
Subject: Re: [PATCH v2 7/7] accel/ivpu: Add handling of VPU_JSM_STATUS_MVNCI_CONTEXT_VIOLATION_HW
Date: Thu,  8 May 2025 12:19:39 -0400
Message-Id: <20250507121852-c49fcd4170320501@stable.kernel.org>
X-Mailer: git-send-email 2.39.5
In-Reply-To:  <20250505103334.79027-8-jacek.lawrynowicz@linux.intel.com>
References: 
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: quoted-printable

[ Sasha's backport helper bot ]

Hi,

Summary of potential issues:
=E2=84=B9=EF=B8=8F This is part 7/7 of a series
=E2=9D=8C Build failures detected

The upstream commit SHA1 provided is correct: dad945c27a42dfadddff1049cf5ae=
417209a8996

WARNING: Author mismatch between patch and upstream commit:
Backport author: Jacek Lawrynowicz<jacek.lawrynowicz@linux.intel.com>
Commit author: Karol Wachowski<karol.wachowski@intel.com>

Note: The patch differs from the upstream commit:
---
1:  dad945c27a42d < -:  ------------- accel/ivpu: Add handling of VPU_JSM_S=
TATUS_MVNCI_CONTEXT_VIOLATION_HW
-:  ------------- > 1:  aeaee199900ee Linux 6.14.5
---

NOTE: These results are for this patch alone. Full series testing will be
performed when all parts are received.

Results of testing on various branches:

| Branch                    | Patch Apply | Build Test |
|---------------------------|-------------|------------|
| stable/linux-5.4.y        |  Success    |  Failed    |

Build Errors:
Build error:
    ssh: connect to host 192.168.1.58 port 22: Connection refused=0D

