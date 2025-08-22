Return-Path: <stable+bounces-172356-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id A9545B314DE
	for <lists+stable@lfdr.de>; Fri, 22 Aug 2025 12:14:21 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 549FF5649EA
	for <lists+stable@lfdr.de>; Fri, 22 Aug 2025 10:13:09 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 6436A2C08D4;
	Fri, 22 Aug 2025 10:13:04 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.b="fGuSBfgB"
X-Original-To: Stable@vger.kernel.org
Received: from mx0b-0031df01.pphosted.com (mx0b-0031df01.pphosted.com [205.220.180.131])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B450029DB6E
	for <Stable@vger.kernel.org>; Fri, 22 Aug 2025 10:13:02 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=205.220.180.131
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1755857584; cv=none; b=onFoLexVw9krGEStoFTW5r1Q3uY6WsdZevevNa2kcE1pZLnsdKO3E2GfUYJY5ccVwbj0VsCpPI+bfjS3Fpx7L2JWn5vtS6aPmw2nNKKJtGK1JLqBseDFgu6jMz8u+KFJOnAXGiXuWhUQGnuklO2z4idBVwI4FMYK7Ua7xxIhCPE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1755857584; c=relaxed/simple;
	bh=Qu5wamvtgPOHj4op5pFq9nE+dkAKOV+C77B4Uq8zqgc=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=N9D4QQujtOSt+VzDCZ3paXUhcwf0Fi+Mdy218qoYLkyT/GhnEddvGEFiuow8lhOYXQEWNmyX5sBZHVuAf95PUyARbZ3UUWk5/Rsum0hIiyzkKGcI57vmpBUAwn591QAOtGIv/MAp6efYLkSdW/P5eL+M66YhK91m/daQGYjUb4U=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com; spf=pass smtp.mailfrom=oss.qualcomm.com; dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.b=fGuSBfgB; arc=none smtp.client-ip=205.220.180.131
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=oss.qualcomm.com
Received: from pps.filterd (m0279869.ppops.net [127.0.0.1])
	by mx0a-0031df01.pphosted.com (8.18.1.2/8.18.1.2) with ESMTP id 57M8UIPo005592
	for <Stable@vger.kernel.org>; Fri, 22 Aug 2025 10:13:01 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qualcomm.com; h=
	cc:content-type:date:from:in-reply-to:message-id:mime-version
	:references:subject:to; s=qcppdkim1; bh=ktdLtsHklNrwvbK6WHHw6N1i
	oePlVUtRlafrkhtR9/E=; b=fGuSBfgBMG7R9fqPCzbaiC26z/RC6FHi/LvG964P
	Zq5ck+ZG2o9TM2EAlXlMPXK2a9FrW5P8uHFKsGnm/hhz1MujhkYqQrqmRkdTOnFu
	zb3EMtRJhUHxiHQ1fzhm3qMc15ii/0skGEcyVKxEwqMNFfw6BODDA0hcBppfFMU6
	Pet7stfgEuAl8WIoVvup3qGscLWr99aDs9bRhU7KsFB7j88VOZ8u6y2DdlAP7OaQ
	tzF8FcV1/Q0Fphv1SkPAyr+Pmitkb9Jx7rc6qoqWxxQV5yqbNb0/TVLeIhUFqVce
	z8G3k6KE2pabGViwtY7OM6WHjqRxbZwGTgVB25oUtOagVQ==
Received: from mail-qk1-f199.google.com (mail-qk1-f199.google.com [209.85.222.199])
	by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 48n52drr71-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128 verify=NOT)
	for <Stable@vger.kernel.org>; Fri, 22 Aug 2025 10:13:01 +0000 (GMT)
Received: by mail-qk1-f199.google.com with SMTP id af79cd13be357-7e8706abd44so507011785a.3
        for <Stable@vger.kernel.org>; Fri, 22 Aug 2025 03:13:01 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1755857580; x=1756462380;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=ktdLtsHklNrwvbK6WHHw6N1ioePlVUtRlafrkhtR9/E=;
        b=i9AtAcUIXLtcJaXPO2WkXasEamsKtzOCb+FQF88Y1yqdNymDe90IlySd9WT27N460S
         o3Td86dFkqMFyo/8PnqB4SYO9u9gth1pUkCNFpw9UPmZpPDrUtd2w//oKlmGV52yjgdj
         oyRWU+001/qugyf7Tw0wAuCGw61XSAaCDUa/dCY9MZcZYIvRbEjzUawhD8WQ8T7XwSw0
         Ffb7/I/rplcakEFH4gRFuCr8a1QopS4lSJBxW5ouDJbWJ9Asu+hqy5Fz0Y1KHIxxqoFp
         oVYdzsTyGeFKgBHqHiSUyynM/QBqjdH0gRFnx53WwuauiHuo4sNdJ1+p/ngdWrvEEE3m
         6VEA==
X-Forwarded-Encrypted: i=1; AJvYcCVf+MB59YZWs8sn5g1q7PucKrvGED0o1MO2j0VOVyFB/D1Y6maN1YK1VLKGox8dfRRueNzmVPs=@vger.kernel.org
X-Gm-Message-State: AOJu0Yz6InwmxsxyYASXdhwFukxKCPVBfGncijE87yV4okJ2gLXiGWkI
	gpYAJPCquCraNqwqVi7j6E5AHi3XkyyK+PD/Mnl/loV5SfZyAVDhzNOrrIiEq5Y3XRmizNw1M2j
	bOl/6v749Zi8+EKD7MNpJfZhYOYKMkdUkNAs1fvUjG4tNMnuZEuUaju4acco=
X-Gm-Gg: ASbGncu2HCpgBghjxMQSRFOFGXFo4rdP23w3YX6DFdx6NC70qyhXlUds6BkgCwXAH6/
	vY7qGAaxBjoGbmrx+ct7NUR71N+7MOvlxgayv/LBP/RSTxB51D8gpQ6lbGFQjfF+TUSzPCbIncr
	ZzC8H5NAxZk/kZwGfQ/908lzlQll+eHYwZWx7GGbqHc4seVihoQQE8Z0qYsWpI+gk29tvhflUlt
	sermVg4XI2K3HT5R92xDs2DTsEiWWUGzTRrLvbghSXhCe2Hy+lzZVBpqqpBSZho57V50lW7eZtT
	K/kTIAmLYO8gKqYtc16NXherR4ki367c7eVeIXBoemneV7R+kOstvYxlatciR9hbtjyEfm0Zac2
	MOQls0F+E4RyI3Yeup2bGoLKHN3qaf1nxeHWAEQ2z3bDU4IQiPKsV
X-Received: by 2002:ac8:5e12:0:b0:4b0:87ac:233 with SMTP id d75a77b69052e-4b2aaa196bbmr25694851cf.5.1755857580369;
        Fri, 22 Aug 2025 03:13:00 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IHlnCz62MvGFGGfOY7Zb1xiypS5D1InHxski9LRLgZOv29qsFZiE/JXKwiBS0HULHnR3aSnuA==
X-Received: by 2002:ac8:5e12:0:b0:4b0:87ac:233 with SMTP id d75a77b69052e-4b2aaa196bbmr25694611cf.5.1755857579892;
        Fri, 22 Aug 2025 03:12:59 -0700 (PDT)
Received: from umbar.lan (2001-14ba-a0c3-3a00-264b-feff-fe8b-be8a.rev.dnainternet.fi. [2001:14ba:a0c3:3a00:264b:feff:fe8b:be8a])
        by smtp.gmail.com with ESMTPSA id 2adb3069b0e04-55cef4732a5sm3386969e87.162.2025.08.22.03.12.58
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 22 Aug 2025 03:12:58 -0700 (PDT)
Date: Fri, 22 Aug 2025 13:12:57 +0300
From: Dmitry Baryshkov <dmitry.baryshkov@oss.qualcomm.com>
To: srinivas.kandagatla@oss.qualcomm.com
Cc: andersson@kernel.org, mathieu.poirier@linaro.org, srichara@quicinc.com,
        linux-arm-msm@vger.kernel.org, linux-remoteproc@vger.kernel.org,
        linux-kernel@vger.kernel.org, Stable@vger.kernel.org
Subject: Re: [PATCH 1/2] rpmsg: glink_native: fix rpmsg device leak
Message-ID: <pnkk65dkrruj5br7mmzolhrln6s53wstshn3fbdktjtjyam6ex@ssjemdrzwap3>
References: <20250822100043.2604794-1-srinivas.kandagatla@oss.qualcomm.com>
 <20250822100043.2604794-2-srinivas.kandagatla@oss.qualcomm.com>
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20250822100043.2604794-2-srinivas.kandagatla@oss.qualcomm.com>
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjUwODIwMDAxMyBTYWx0ZWRfXyEc195+BaUGD
 EYTU2qCs1JxsrED5Ec6cBpyPr8d9CyFfpbcWckVzOIz5aWEYeaaLgTWxYV+wB0Sk9khhgrfe9rW
 NklJDPkNO36eoAdl0Xli7Lnju+7Qkt2ZMCNpWBL8gXXaHN4cv/oA7FrqqEn+CVd1ImB02cfrZvy
 0dQpwDNnNZc22sUNotKTecBPueDd0uvL7sPNWZdTheWCc/TmsCPtCe13KQXdORYmmRKr8GrFtqm
 6eIpswpOpzrIQYURdD79eL0wZ7rNkrXyK23Qq90urkNNtlOdjP6L77AhIGVViCfx+9yx+gLZa8Z
 FYhZ4gLX+64n6OmgQdGhyfvKFp6FJIj8GhaSpRvb0lZrT1XKWHuTMFR1Vt2izUcYjk77qNBD8X0
 mfb/oPumhh/g9+7XZo+q6v5Tqv9l2A==
X-Proofpoint-ORIG-GUID: crSUZxw6cohQjRK3Dx0OnMdlN3SBiYkL
X-Proofpoint-GUID: crSUZxw6cohQjRK3Dx0OnMdlN3SBiYkL
X-Authority-Analysis: v=2.4 cv=SoXJKPO0 c=1 sm=1 tr=0 ts=68a842ad cx=c_pps
 a=HLyN3IcIa5EE8TELMZ618Q==:117 a=xqWC_Br6kY4A:10 a=kj9zAlcOel0A:10
 a=2OwXVqhp2XgA:10 a=EUspDBNiAAAA:8 a=VwQbUJbxAAAA:8 a=NZc0qn8vRsVWR2Eyjd0A:9
 a=CjuIK1q_8ugA:10 a=bTQJ7kPSJx9SKPbeHEYW:22
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1099,Hydra:6.1.9,FMLib:17.12.80.40
 definitions=2025-08-22_03,2025-08-20_03,2025-03-28_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 impostorscore=0 spamscore=0 adultscore=0 lowpriorityscore=0 bulkscore=0
 priorityscore=1501 suspectscore=0 malwarescore=0 phishscore=0 clxscore=1015
 classifier=typeunknown authscore=0 authtc= authcc= route=outbound adjust=0
 reason=mlx scancount=1 engine=8.19.0-2508110000 definitions=main-2508200013

On Fri, Aug 22, 2025 at 11:00:42AM +0100, srinivas.kandagatla@oss.qualcomm.com wrote:
> From: Srinivas Kandagatla <srinivas.kandagatla@oss.qualcomm.com>

Please adjust your git's sendemail.from line to include your name. Then
git-send-email will not generate extra From headers.

> 
> While testing rpmsg-char interface it was noticed that duplicate sysfs
> entries are getting created and below warning is noticed.
> 
> Reason for this is that we are leaking rpmsg device pointer, setting it
> null without actually unregistering device.
> Any further attempts to unregister fail because rpdev is NULL,
> resulting in a leak.
> 
> Fix this by unregistering rpmsg device before removing its reference
> from rpmsg channel.
> 
> sysfs: cannot create duplicate filename '/devices/platform/soc@0/3700000.remot
> eproc/remoteproc/remoteproc1/3700000.remoteproc:glink-edge/3700000.remoteproc:
> glink-edge.adsp_apps.-1.-1'
> [  114.115347] CPU: 0 UID: 0 PID: 9 Comm: kworker/0:0 Not
>  tainted 6.16.0-rc4 #7 PREEMPT
> [  114.115355] Hardware name: Qualcomm Technologies, Inc. Robotics RB3gen2 (DT)
> [  114.115358] Workqueue: events qcom_glink_work
> [  114.115371] Call trace:8
> [  114.115374]  show_stack+0x18/0x24 (C)
> [  114.115382]  dump_stack_lvl+0x60/0x80
> [  114.115388]  dump_stack+0x18/0x24
> [  114.115393]  sysfs_warn_dup+0x64/0x80
> [  114.115402]  sysfs_create_dir_ns+0xf4/0x120
> [  114.115409]  kobject_add_internal+0x98/0x260
> [  114.115416]  kobject_add+0x9c/0x108
> [  114.115421]  device_add+0xc4/0x7a0
> [  114.115429]  rpmsg_register_device+0x5c/0xb0
> [  114.115434]  qcom_glink_work+0x4bc/0x820
> [  114.115438]  process_one_work+0x148/0x284
> [  114.115446]  worker_thread+0x2c4/0x3e0
> [  114.115452]  kthread+0x12c/0x204
> [  114.115457]  ret_from_fork+0x10/0x20
> [  114.115464] kobject: kobject_add_internal failed for 3700000.remoteproc:
> glink-edge.adsp_apps.-1.-1 with -EEXIST, don't try to register things with
> the same name in the same directory.
> [  114.250045] rpmsg 3700000.remoteproc:glink-edge.adsp_apps.-1.-1:
> device_add failed: -17
> 
> Fixes: 835764ddd9af ("rpmsg: glink: Move the common glink protocol implementation to glink_native.c")
> Cc: <Stable@vger.kernel.org>
> Signed-off-by: Srinivas Kandagatla <srinivas.kandagatla@oss.qualcomm.com>
> ---
>  drivers/rpmsg/qcom_glink_native.c | 8 ++++++++
>  1 file changed, 8 insertions(+)
> 

Reviewed-by: Dmitry Baryshkov <dmitry.baryshkov@oss.qualcomm.com>


-- 
With best wishes
Dmitry

