Return-Path: <stable+bounces-98154-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 92E8B9E2A84
	for <lists+stable@lfdr.de>; Tue,  3 Dec 2024 19:13:32 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 590CF2849B6
	for <lists+stable@lfdr.de>; Tue,  3 Dec 2024 18:13:31 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 7AD891FC7DB;
	Tue,  3 Dec 2024 18:13:29 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="ATlK2V9n"
X-Original-To: stable@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3BBF61F8901
	for <stable@vger.kernel.org>; Tue,  3 Dec 2024 18:13:29 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1733249609; cv=none; b=peIZZqNPTC0d2ZzlkiJvDhf5WP4wNcDSQji885SGE6KWC8oD0wIvJ5xTFe58cEXXP2hivUYBHz8Jdx7vo9bseJ6hFV0LA+j9qGHSYw4kqAfFRUI4k3XOAyH6nGSSFMD5yHfUfHzdfpYE3ilvnktOZXM2lCa5SKZRTha2qIZpUSk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1733249609; c=relaxed/simple;
	bh=QE7guQLQc4TxHDnqpERptn9fD7pUqlsSSz+x4g/qnoI=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=CG3C3na7Ed3rM+nOq0ETXTzS4CKAtAp4oyH7jJmai2Vqm3xerc4I9TtxNb0ZucmH6sOUz84kzgHWAmZwqchP2x0Hrv+N/HLSdcHXaxDDkkLrZSqgConvDhVTRb8uJKSUZALikMRC26vcgTooqWp7MyX4u+w/VmbLQsKp0TlpmQc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=ATlK2V9n; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id A3BB6C4CECF;
	Tue,  3 Dec 2024 18:13:28 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1733249609;
	bh=QE7guQLQc4TxHDnqpERptn9fD7pUqlsSSz+x4g/qnoI=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=ATlK2V9nB3qtHs2KL+XCVsUZFxiYBhEXF+y5WppNaVOZqD6iXXdOrMMgFB9eSIDAv
	 27EwARBXf35TuWoFvfcXDBpWQ5VIAOYPctvfWCiVg/19fIMSxVgY6Wc7CRbEmq4SpA
	 gWwcF0rW7pmBLSdVdqc9HEaotp0xfziJZxNRP1BYHowRcHch2Rx4p9K9rehlUEIAE0
	 H4D975XBAvuF0vJAeR6V3uyt5WmPqaaNu/ZTzoOSU1y30nDfH6T71IaQAR2rNN5yzi
	 1LmnvLXB1DSLXERozhqGmsRpCsQB3xiHk73QJDyCZrxI3wpnaQZgyQSabHw64JqQiD
	 WqQe9piMWTnaA==
From: Sasha Levin <sashal@kernel.org>
To: stable@vger.kernel.org
Cc: =?UTF-8?q?Cs=C3=B3k=C3=A1s=2C=20Bence?= <csokas.bence@prolan.hu>,
	Sasha Levin <sashal@kernel.org>
Subject: Re: [PATCH 6.11 v3 2/3] net: fec: refactor PPS channel configuration
Date: Tue,  3 Dec 2024 13:13:27 -0500
Message-ID: <20241202125000-0f3090187f6d8f1c@stable.kernel.org>
X-Mailer: git-send-email 2.43.0
In-Reply-To:  <20241202155713.3564460-3-csokas.bence@prolan.hu>
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

Found matching upstream commit: bf8ca67e21671e7a56e31da45360480b28f185f1

WARNING: Author mismatch between patch and found commit:
Backport author: =?UTF-8?q?Cs=C3=B3k=C3=A1s=2C=20Bence?= <csokas.bence@prolan.hu>
Commit author: Francesco Dolcini <francesco.dolcini@toradex.com>


Status in newer kernel trees:
6.12.y | Not found
6.11.y | Not found

Note: The patch differs from the upstream commit:
---
1:  bf8ca67e21671 ! 1:  6987e60828e70 net: fec: refactor PPS channel configuration
    @@ Commit message
         Reviewed-by: Csókás, Bence <csokas.bence@prolan.hu>
         Signed-off-by: Paolo Abeni <pabeni@redhat.com>
     
    +    (cherry picked from commit bf8ca67e21671e7a56e31da45360480b28f185f1)
    +    Signed-off-by: Csókás, Bence <csokas.bence@prolan.hu>
    +
      ## drivers/net/ethernet/freescale/fec_ptp.c ##
     @@
      #define FEC_CC_MULT	(1 << 31)
---

Results of testing on various branches:

| Branch                    | Patch Apply | Build Test |
|---------------------------|-------------|------------|
| stable/linux-6.11.y       |  Success    |  Success   |

