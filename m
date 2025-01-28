Return-Path: <stable+bounces-110979-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 1153AA20E10
	for <lists+stable@lfdr.de>; Tue, 28 Jan 2025 17:09:31 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 69887188226A
	for <lists+stable@lfdr.de>; Tue, 28 Jan 2025 16:09:35 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 3ABCE1D63C8;
	Tue, 28 Jan 2025 16:09:23 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="dx3jCmkf"
X-Original-To: stable@vger.kernel.org
Received: from mail-lf1-f44.google.com (mail-lf1-f44.google.com [209.85.167.44])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D0D361A8401
	for <stable@vger.kernel.org>; Tue, 28 Jan 2025 16:09:20 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.167.44
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1738080563; cv=none; b=D8HcD4Vk2MsYSPNlfWZ4PSa/tqHQL4ZQjh0e7n/nvJByYy2YLY6uWk+H4FA+Z+9P1ZetxcGg5t0pr5Cuzr8GC3pSgBIWRgc4heT3Q+Mr+/ricyMumMpnoQG1cJv9C5Zak+Ce84SNt/KJfnn367WPHLAlXj+AsmjPKPbmCVsGFqU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1738080563; c=relaxed/simple;
	bh=BEceo0pyOWNwrQgM5P+ElC1rpnayGRzLlO9HRB1nWeo=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=FZTUQ+5hbPq4Dkz6LRJsi/1fEO6ZGRCeJcyNhpjKJvskbiMG3EVkshW4Lv63yIRB8ba1hXGj1kKVEQeMiGCAUXMFGFp2cQZkvtNEdYJeBOqPFQsdjtfojAj8mU5dLfqpzFRUrJmt+giSJl5iLEc0w6/litTOPUW0Cos4PBcn4lw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org; spf=pass smtp.mailfrom=linaro.org; dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b=dx3jCmkf; arc=none smtp.client-ip=209.85.167.44
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linaro.org
Received: by mail-lf1-f44.google.com with SMTP id 2adb3069b0e04-53e3c47434eso6226437e87.3
        for <stable@vger.kernel.org>; Tue, 28 Jan 2025 08:09:20 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1738080559; x=1738685359; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=8hyWKduVNC9ouiWAJq4WnkCOtxjNZB1VnYrFoYk4udA=;
        b=dx3jCmkfR2fG5MyNInak4Wl8/kJyRHvcvDkd+kYwncRIWwuH4O1imGSdVmwdZvXMup
         o8SCsNc7isyz7PQodm1Mpo5ipYDbJ4+fxE9AZRm7mFskRF76ChN2jP7bEvttVRGisCbu
         s+yS9N+sggF3Bj7TbZi7qHvMju42dF736dgNptJvGnbtyDfnC58513UQJ9RLvaqpGdap
         f65GD40Wp86/kbSFQ2M/KTS3V7+d5WrI8/m3iNb7XwKHaBQLBpZCY/KrRGiTLWt5TCdo
         fUHb8eJsouwpYBrogDTh8LgSo+XUJ7FPMOZrkYoxA6bBO0SrfoTQYS4Hsotw7/DZrMxz
         kwug==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1738080559; x=1738685359;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=8hyWKduVNC9ouiWAJq4WnkCOtxjNZB1VnYrFoYk4udA=;
        b=sMNbwxqN9VBYmStacB6GfUfoC5YcQ6PkPE7sayXAQdEXfWcot5MqLogzzfGhscx33c
         i0wSvJjyGnCVNsuoYcQIB4SrtrpCkFDYLwsw5ledfjMdg2NuYlkKvJaXq6J7pYShwI+F
         xCNCpFobewrvy5961Z9KSmkVEdlPkEBI4sVhypQHIyoOwyEDQMOyjwP96bVqLKhIEgwG
         suuoOnWwOcJV/ywXBkeVHrsdOMOzArQqNL2lKH/zkN2KM6uTc0lR7l3hUmWD+cl8rlHh
         IZEp13ERQrzplu6EL2OazTHlMobZwzMDTTRPgWw2aoaXxM8suZIrcqzUJeyuMXTyVFdw
         RQ/w==
X-Forwarded-Encrypted: i=1; AJvYcCXUmNK01ZaTrC0yw4so/CRoWCNsNrm/U/bfyMvvXVjzzPQ3FwbQ+X03dI2gba1J5YTIY4Y5DeU=@vger.kernel.org
X-Gm-Message-State: AOJu0YwHp2ljcS5utENSA/Dae7Oo2ku0R6dkuKEe2BSmJh80ZD6/mJSt
	bDUcPcVMxb9CZYqQbEwiJXGE9775p6lUsh7D6iBnOjvJdx8LymJkF04SYfPgt2g=
X-Gm-Gg: ASbGncsQrQMwLsbiIw7+TlqA/xP9TpZqMPND5RdPaEAFLwu+nvCA4fmyTzB2pUX8UJl
	CCOakLQYPkCiPiOtdIHwtUi3/sLJiIpzTAQB7ORL8yuaMsQOEgQ5r28kY5389WCIe1gTycsp8ss
	3cnjG/A+DMlkQWldSWn5kcx2P7caHNGwAFFQPLHzkz1j3v0I/4voeusJpERxi7QepONXa7271/k
	8t8hdt++7W4k0UfXml6HJsTIIaOrdrzHlTSJAGJYpy46EbbTE1k8dg1akK9NhmuQOuAnRc2V8Wp
	VRzwTjFnz3HSFXsbp/WAHPgr2cUBODWXYQ1FPpUNtkO7pphS/YtulmLKj9pX7GlJHSgZWO94aHJ
	LCY3KMw==
X-Google-Smtp-Source: AGHT+IHC2sjROuFhZA0YjUt5mQF/zuLJNR2MX3vLn942u6zWQ2Beugmg5eWKUBTr/IVWHBJ5ABtFKg==
X-Received: by 2002:a19:7618:0:b0:542:1b6b:1e89 with SMTP id 2adb3069b0e04-5439c216beemr12823836e87.7.1738080558882;
        Tue, 28 Jan 2025 08:09:18 -0800 (PST)
Received: from eriador.lumag.spb.ru (2001-14ba-a0c3-3a00--b8c.rev.dnainternet.fi. [2001:14ba:a0c3:3a00::b8c])
        by smtp.gmail.com with ESMTPSA id 2adb3069b0e04-543c836840fsm1670414e87.132.2025.01.28.08.09.16
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 28 Jan 2025 08:09:17 -0800 (PST)
Date: Tue, 28 Jan 2025 18:09:15 +0200
From: Dmitry Baryshkov <dmitry.baryshkov@linaro.org>
To: Ajit Pandey <quic_ajipan@quicinc.com>
Cc: Bjorn Andersson <andersson@kernel.org>, 
	Michael Turquette <mturquette@baylibre.com>, Stephen Boyd <sboyd@kernel.org>, 
	Imran Shaik <quic_imrashai@quicinc.com>, Taniya Das <quic_tdas@quicinc.com>, 
	linux-arm-msm@vger.kernel.org, linux-clk@vger.kernel.org, linux-kernel@vger.kernel.org, 
	Jagadeesh Kona <quic_jkona@quicinc.com>, Satya Priya Kakitapalli <quic_skakitap@quicinc.com>, 
	stable@vger.kernel.org
Subject: Re: [PATCH] clk: qcom: clk-branch: Fix invert halt status bit check
 for votable clocks
Message-ID: <sfrnlwwmoh5ic5c5r6b3mzh4dq2ud27qu3bclcm4p5vwfbckhw@utti7c4ejxr6>
References: <20250128-push_fix-v1-1-fafec6747881@quicinc.com>
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20250128-push_fix-v1-1-fafec6747881@quicinc.com>

On Tue, Jan 28, 2025 at 05:08:35PM +0530, Ajit Pandey wrote:
> BRANCH_HALT_ENABLE and BRANCH_HALT_ENABLE_VOTED flags are used to check
> halt status of branch clocks, which have an inverted logic for the halt
> bit in CBCR register. However, the current logic in the _check_halt()
> method only compares the BRANCH_HALT_ENABLE flags, ignoring the votable
> branch clocks.
> 
> Update the logic to correctly handle the invert logic for votable clocks
> using the BRANCH_HALT_ENABLE_VOTED flags.
> 
> Fixes: 9092d1083a62 ("clk: qcom: branch: Extend the invert logic for branch2 clocks")
> Cc: stable@vger.kernel.org
> Signed-off-by: Ajit Pandey <quic_ajipan@quicinc.com>
> ---
> This patch update the logic to correctly handle the invert logic for votable
> clocks using the BRANCH_HALT_ENABLE_VOTED flags.
> ---
>  drivers/clk/qcom/clk-branch.c | 4 ++--
>  1 file changed, 2 insertions(+), 2 deletions(-)
> 

Reviewed-by: Dmitry Baryshkov <dmitry.baryshkov@linaro.org>

-- 
With best wishes
Dmitry

