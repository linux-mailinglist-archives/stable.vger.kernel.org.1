Return-Path: <stable+bounces-58363-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 8CE4B92B698
	for <lists+stable@lfdr.de>; Tue,  9 Jul 2024 13:15:22 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 0F1C21F23A70
	for <lists+stable@lfdr.de>; Tue,  9 Jul 2024 11:15:22 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id C8EE9158211;
	Tue,  9 Jul 2024 11:15:12 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="KjNeS0jE"
X-Original-To: stable@vger.kernel.org
Received: from mail-yw1-f179.google.com (mail-yw1-f179.google.com [209.85.128.179])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 839561586C3
	for <stable@vger.kernel.org>; Tue,  9 Jul 2024 11:15:09 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.179
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1720523712; cv=none; b=c2DNiSIzoEzBZeNlw2xoYxEqwVp4F6AZUtaf6FslFFWDtcdSvk/HiVuvJiueHwYt4IChh6ZkZ3q0dZbvZZhU5b6fZK82ZpsYl/pW6tL3jEilquypyGMjcX6lR+X1YfRSaEoO5qu64DGUJDmbin78y+vnD1IfgeXdORiWxl60ZWM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1720523712; c=relaxed/simple;
	bh=yQ9NM+l1zVqq0j7T77l/b9HGHEwF0xiqRl64ejpWhBk=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=lH4Lk+zEZQk/27gqOGtw9KYTPb9BL+WkYpBN1oKfDYeNX9CyPEhtxMhxVK34o8PxDmUKoqYpEpTxOqZEZi9uKrP++cyDQYwXesOqeIiwbxSHOR9ENBuyZ9GRYn3E+7/rqNob8ovfPjh3YNzz3FtRxtCClCd2j5gILf4t7o2hG5U=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org; spf=pass smtp.mailfrom=linaro.org; dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b=KjNeS0jE; arc=none smtp.client-ip=209.85.128.179
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linaro.org
Received: by mail-yw1-f179.google.com with SMTP id 00721157ae682-6512866fa87so43490307b3.2
        for <stable@vger.kernel.org>; Tue, 09 Jul 2024 04:15:09 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1720523708; x=1721128508; darn=vger.kernel.org;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:from:to:cc:subject:date:message-id:reply-to;
        bh=1xs0HKvjIXU9N0dl5ke31NoTuxcyqc28H/Jk8DSGVHw=;
        b=KjNeS0jEhFg1AgPLy5il0ZcjuzYFPO+xHYlWzssXh9rWQhTbaswDUs8bEeLd5WVxFb
         JxKyPED0Z1HRSWl4+MxU619nOteTstGGwO8H8VZHoeilUydHU6DAktmaiVnhiR4b68YN
         WVQ5RFONPmMOkIeBCBPOi91M28eJVBai/4OvVbW9e4zgwE2PAD1y+axc0YFd1vyIJeg5
         PcgcHgM8UNnQ/Q3cTKgObReaz+TR3iVDNcvLXMATTNwOu/Pu1GzkVJFWZOz32m99G0zq
         E7RMhkmy8ekaFJeRgU2tI1pEeOPh7LxpByUnH78r/psPoGlN1a8oLB7AZ18HVmEhnnsY
         3jag==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1720523708; x=1721128508;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=1xs0HKvjIXU9N0dl5ke31NoTuxcyqc28H/Jk8DSGVHw=;
        b=mTML5qjplhXeHyTS7PdW8v6Y5OEraIDSJTHyd+RMqTPb2ksp9m3gTr9HBGZdJdLj6w
         I6tmntseWrCOdllcaaog/VJyZOm5f/yswQ/eW+WO3pXCgy7Kf6OnXbLE5VXdBtwvJ820
         8uq1dPbSOxw0WaWOEnDpYndaSgf7+r2EZRvvBRIMoDuKHmlJVUgPdHv3M0gx9kAL7dij
         vgndIGF93lk1S8t6G60XZy7x7zRLaQ8jT/C0HhMWqB+dEs9B3YerJvyuTCbYdjl3iD4X
         y0wDKD2iRc1EDgoR6X13CMTO0NNVmXjA6ZWMF6I+mER79dO9wMlI8qC+zku3Oy5EAq+L
         6RsA==
X-Forwarded-Encrypted: i=1; AJvYcCX4pn/QX7RY6iHVVAD2aT/LWBGB4ruNtGAe8vU8IOTGJ60aQX4ThN0r4pf1vJIa2ro8yOdHKUgQjITlsGwRvI4Eax+bcP1Q
X-Gm-Message-State: AOJu0YxmzlTUWD/8EC2VhKksC2PBvavYOWWg9L2KtC11KYl+2nGCTkgX
	5F/hn/Mrh64DeOHZo+/YuWjAFkxjJK0p4lpz1BMuHr0ZUJBJFlpeDafsQgu3UzoUJCxh6Yvut1C
	x0FVCW+BMd+5YEQbPuBF91M7lzPFkmmK3kk+j1w==
X-Google-Smtp-Source: AGHT+IEe3nga3KVXtHrrwMw0LhHVXjdHyDPZ5uKUnuXkRHUYNX06lcrnyme+JwGrKLNVy4VLF2PrLdXqWcdfOSeg4IQ=
X-Received: by 2002:a81:5b42:0:b0:64a:6eda:fc60 with SMTP id
 00721157ae682-658ee69ac4cmr26076237b3.4.1720523708479; Tue, 09 Jul 2024
 04:15:08 -0700 (PDT)
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20240625-avoid_mxc_retention-v2-1-af9c2f549a5f@quicinc.com>
In-Reply-To: <20240625-avoid_mxc_retention-v2-1-af9c2f549a5f@quicinc.com>
From: Ulf Hansson <ulf.hansson@linaro.org>
Date: Tue, 9 Jul 2024 13:14:32 +0200
Message-ID: <CAPDyKFpid-LEqqSXBHYRc6CKdHpmT+FnS3xrCTt7Z0RhcCSfCg@mail.gmail.com>
Subject: Re: [PATCH v2] pmdomain: qcom: rpmhpd: Skip retention level for Power Domains
To: Taniya Das <quic_tdas@quicinc.com>
Cc: Bjorn Andersson <andersson@kernel.org>, Konrad Dybcio <konrad.dybcio@linaro.org>, 
	Andy Gross <agross@kernel.org>, linux-arm-msm@vger.kernel.org, linux-pm@vger.kernel.org, 
	linux-kernel@vger.kernel.org, quic_jkona@quicinc.com, 
	quic_imrashai@quicinc.com, stable@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"

On Tue, 25 Jun 2024 at 06:33, Taniya Das <quic_tdas@quicinc.com> wrote:
>
> In the cases where the power domain connected to logics is allowed to
> transition from a level(L)-->power collapse(0)-->retention(1) or
> vice versa retention(1)-->power collapse(0)-->level(L)  will cause the
> logic to lose the configurations. The ARC does not support retention
> to collapse transition on MxC rails.
>
> The targets from SM8450 onwards the PLL logics of clock controllers are
> connected to MxC rails and the recommended configurations are carried
> out during the clock controller probes. The MxC transition as mentioned
> above should be skipped to ensure the PLL settings are intact across
> clock controller power on & off.
>
> On older targets that do not split MX into MxA and MxC does not collapse
> the logic and it is parked always at RETENTION, thus this issue is never
> observed on those targets.
>
> Cc: stable@vger.kernel.org # v5.17
> Reviewed-by: Bjorn Andersson <andersson@kernel.org>
> Signed-off-by: Taniya Das <quic_tdas@quicinc.com>

Applied for fixes, thanks!

Kind regards
Uffe


> ---
> [Changes in v2]: Incorporate the comments in the commit text.
> ---
>  drivers/pmdomain/qcom/rpmhpd.c | 7 +++++++
>  1 file changed, 7 insertions(+)
>
> diff --git a/drivers/pmdomain/qcom/rpmhpd.c b/drivers/pmdomain/qcom/rpmhpd.c
> index de9121ef4216..d2cb4271a1ca 100644
> --- a/drivers/pmdomain/qcom/rpmhpd.c
> +++ b/drivers/pmdomain/qcom/rpmhpd.c
> @@ -40,6 +40,7 @@
>   * @addr:              Resource address as looped up using resource name from
>   *                     cmd-db
>   * @state_synced:      Indicator that sync_state has been invoked for the rpmhpd resource
> + * @skip_retention_level: Indicate that retention level should not be used for the power domain
>   */
>  struct rpmhpd {
>         struct device   *dev;
> @@ -56,6 +57,7 @@ struct rpmhpd {
>         const char      *res_name;
>         u32             addr;
>         bool            state_synced;
> +       bool            skip_retention_level;
>  };
>
>  struct rpmhpd_desc {
> @@ -173,6 +175,7 @@ static struct rpmhpd mxc = {
>         .pd = { .name = "mxc", },
>         .peer = &mxc_ao,
>         .res_name = "mxc.lvl",
> +       .skip_retention_level = true,
>  };
>
>  static struct rpmhpd mxc_ao = {
> @@ -180,6 +183,7 @@ static struct rpmhpd mxc_ao = {
>         .active_only = true,
>         .peer = &mxc,
>         .res_name = "mxc.lvl",
> +       .skip_retention_level = true,
>  };
>
>  static struct rpmhpd nsp = {
> @@ -819,6 +823,9 @@ static int rpmhpd_update_level_mapping(struct rpmhpd *rpmhpd)
>                 return -EINVAL;
>
>         for (i = 0; i < rpmhpd->level_count; i++) {
> +               if (rpmhpd->skip_retention_level && buf[i] == RPMH_REGULATOR_LEVEL_RETENTION)
> +                       continue;
> +
>                 rpmhpd->level[i] = buf[i];
>
>                 /* Remember the first corner with non-zero level */
>
> ---
> base-commit: 62c97045b8f720c2eac807a5f38e26c9ed512371
> change-id: 20240625-avoid_mxc_retention-b095a761d981
>
> Best regards,
> --
> Taniya Das <quic_tdas@quicinc.com>
>

