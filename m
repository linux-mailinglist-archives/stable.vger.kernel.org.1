Return-Path: <stable+bounces-134694-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id CA161A9433D
	for <lists+stable@lfdr.de>; Sat, 19 Apr 2025 13:47:37 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id CECD38A451D
	for <lists+stable@lfdr.de>; Sat, 19 Apr 2025 11:47:20 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 0E6C41D63D8;
	Sat, 19 Apr 2025 11:47:34 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="tGzDw0cD"
X-Original-To: stable@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C278018DB29
	for <stable@vger.kernel.org>; Sat, 19 Apr 2025 11:47:33 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1745063253; cv=none; b=A4etWA++peKbX8RRHDXiflv6TL4Bx6V6dnI0lc3GiYN3UOU5R6cM51JfpTHIe/FXp5sAWxPv5v3PI9bBRl/5h6t06FdUzuMNYqa404ueENAbh8+VKr0irmIc2IK2r/EfZA5atsgeNrve/PShmcd8m4lvCiSXnE2924Y9GR+E/no=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1745063253; c=relaxed/simple;
	bh=43iaym+jY91WrrKwHokBLrGn0aZUyE3HIvUZv6sPFHo=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version:Content-Type; b=p2VJqSCho1AIQ5j+SDFU7hm7+I73xzvKRM2g8CUulFksdVK6dpRRzLRudUfZasK9oB5Ljj289WPDwF7aph0k0ZmOE5ATosSqsG1HEiDbdONzc0IRldvogMI+W0hU4TQCtmnXfH8P1TuZJDJUX6gsOPVVIR4wZQqxFoftcVT9Pdg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=tGzDw0cD; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 38A90C4CEE7;
	Sat, 19 Apr 2025 11:47:33 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1745063253;
	bh=43iaym+jY91WrrKwHokBLrGn0aZUyE3HIvUZv6sPFHo=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=tGzDw0cDP1IiUfIOPlc2YFzSnHlIOfOCVKhMbwhdYzU/jPRDRG6z9B5bWiG2r7i1F
	 7x7lgoKSGf5sJ8OkzsT7IvS3Bgq7LbF3uIt7/j3wyOl90HmTWoJ57BxkvmYcD+QZuk
	 4tX/vRHjXVzu8DIjGrChZfU3qTJHQW7p6+8D88Me6+WY/jXFgc2pfGyldE3RW20Wy+
	 wPbWC/2BHNMeMAoaIyJhl5tBT8wwj32I1v7MNK0k3ANxQ5LJbHeg/GCpZhNNtCj7Gh
	 CLpGaCJEcK3FHE/kmnY2GrACQ0onNzCfJtA+w4gESbmACWqoVicsMbrVRhVevCMfFe
	 njhRaPi7UDIyg==
From: Sasha Levin <sashal@kernel.org>
To: stable@vger.kernel.org,
	Feng.Liu3@windriver.com
Cc: Sasha Levin <sashal@kernel.org>
Subject: Re: [PATCH 5.10.y] drivers: staging: rtl8723bs: Fix deadlock in rtw_surveydone_event_callback()
Date: Sat, 19 Apr 2025 07:47:32 -0400
Message-Id: <20250418165238-0f6b33e7ed2938d4@stable.kernel.org>
X-Mailer: git-send-email 2.39.5
In-Reply-To:  <20250418022918.80411-1-Feng.Liu3@windriver.com>
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
⚠️ Found follow-up fixes in mainline

The upstream commit SHA1 provided is correct: cc7ad0d77b51c872d629bcd98aea463a3c4109e7

WARNING: Author mismatch between patch and upstream commit:
Backport author: Feng Liu<Feng.Liu3@windriver.com>
Commit author: Duoming Zhou<duoming@zju.edu.cn>

Status in newer kernel trees:
6.14.y | Present (exact SHA1)
6.13.y | Present (exact SHA1)
6.12.y | Present (exact SHA1)
6.6.y | Present (exact SHA1)
6.1.y | Present (exact SHA1)
5.15.y | Present (different SHA1: f89f6c3ebf69)

Found fixes commits:
3f467036093f drivers: staging: rtl8723bs: Fix locking in rtw_scan_timeout_handler()

Note: The patch differs from the upstream commit:
---
1:  cc7ad0d77b51c ! 1:  6fa69b9b220a6 drivers: staging: rtl8723bs: Fix deadlock in rtw_surveydone_event_callback()
    @@ Metadata
      ## Commit message ##
         drivers: staging: rtl8723bs: Fix deadlock in rtw_surveydone_event_callback()
     
    +    [ Upstream commit cc7ad0d77b51c872d629bcd98aea463a3c4109e7 ]
    +
         There is a deadlock in rtw_surveydone_event_callback(),
         which is shown below:
     
    @@ Commit message
         Signed-off-by: Duoming Zhou <duoming@zju.edu.cn>
         Link: https://lore.kernel.org/r/20220409061836.60529-1-duoming@zju.edu.cn
         Signed-off-by: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
    +    [Minor context change fixed]
    +    Signed-off-by: Feng Liu <Feng.Liu3@windriver.com>
    +    Signed-off-by: He Zhe <Zhe.He@windriver.com>
     
      ## drivers/staging/rtl8723bs/core/rtw_mlme.c ##
     @@ drivers/staging/rtl8723bs/core/rtw_mlme.c: void rtw_surveydone_event_callback(struct adapter	*adapter, u8 *pbuf)
    - 	}
    + 	RT_TRACE(_module_rtl871x_mlme_c_, _drv_info_, ("rtw_surveydone_event_callback: fw_state:%x\n\n", get_fwstate(pmlmepriv)));
      
      	if (check_fwstate(pmlmepriv, _FW_UNDER_SURVEY)) {
     +		spin_unlock_bh(&pmlmepriv->lock);
      		del_timer_sync(&pmlmepriv->scan_to_timer);
     +		spin_lock_bh(&pmlmepriv->lock);
      		_clr_fwstate_(pmlmepriv, _FW_UNDER_SURVEY);
    - 	}
    + 	} else {
      
     @@ drivers/staging/rtl8723bs/core/rtw_mlme.c: void rtw_scan_timeout_handler(struct timer_list *t)
    - 						  mlmepriv.scan_to_timer);
    - 	struct	mlme_priv *pmlmepriv = &adapter->mlmepriv;
    + 
    + 	DBG_871X(FUNC_ADPT_FMT" fw_state =%x\n", FUNC_ADPT_ARG(adapter), get_fwstate(pmlmepriv));
      
     -	spin_lock_bh(&pmlmepriv->lock);
     +	spin_lock_irq(&pmlmepriv->lock);
---

Results of testing on various branches:

| Branch                    | Patch Apply | Build Test |
|---------------------------|-------------|------------|
| stable/linux-5.10.y       |  Success    |  Success   |

