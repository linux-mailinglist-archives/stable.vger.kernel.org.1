Return-Path: <stable+bounces-145070-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id 1DECCABD839
	for <lists+stable@lfdr.de>; Tue, 20 May 2025 14:31:09 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id DE8717A9BA8
	for <lists+stable@lfdr.de>; Tue, 20 May 2025 12:29:51 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id B353E19CC1C;
	Tue, 20 May 2025 12:31:01 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.b="EJS4Cv0g"
X-Original-To: stable@vger.kernel.org
Received: from mx0b-0031df01.pphosted.com (mx0b-0031df01.pphosted.com [205.220.180.131])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B9DB033F3
	for <stable@vger.kernel.org>; Tue, 20 May 2025 12:30:59 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=205.220.180.131
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1747744261; cv=none; b=aUUWHoBwGNRM/gQdkDxMPoPv6h8gXhBoa4FYimN34gtHXz72qb/jdZ+2wj6QolRvnGjj/OHqY0DEOUZiz7erumjA1qyVT9xllkVci9gLN61rAh4Dmxasfk0w0MTcU2ZjfrbrObPqxcA1cwev0ELT34C0jaKRsS5v/7AfG1DsOzw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1747744261; c=relaxed/simple;
	bh=06+bqTZRg6ptyJRvbT7uUPZ5sbC90XpRGa1TPKHK3ak=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=qz5NwdNG+G4epwQkLxCoeeDmsJaHdNeDoesrkei6s1U7Ki2cUnwyDHwOSCBUpEE6PPiLbYbVfsgfnntQUuPML3tvRRIZi8/y39w9k7F4YUc9jojiMwY9Pc7qYjx/PYfAFXzlnkVN5yXsYW9M2ye8YIZQZVSpu4SROIs8dveXM6Y=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com; spf=pass smtp.mailfrom=oss.qualcomm.com; dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.b=EJS4Cv0g; arc=none smtp.client-ip=205.220.180.131
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=oss.qualcomm.com
Received: from pps.filterd (m0279869.ppops.net [127.0.0.1])
	by mx0a-0031df01.pphosted.com (8.18.1.2/8.18.1.2) with ESMTP id 54K8TspS021066
	for <stable@vger.kernel.org>; Tue, 20 May 2025 12:30:58 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qualcomm.com; h=
	cc:content-transfer-encoding:content-type:date:from:in-reply-to
	:message-id:mime-version:references:subject:to; s=qcppdkim1; bh=
	rXBDW4Zj2qm1riop642/edycQKRUKMuQeCUhQ63b6q8=; b=EJS4Cv0giDcYWB+q
	tydSuaxk5wnXQffmNjNIqrEXlhg4UMyIH2J9ITJ66l5kwZrK0FUugWh52w8KoLAp
	z/pbxDaNE4dGHzfyJ4k3w8/nQ3YAkUz1fXUkAi8734kFcaDugo2GLEer42LimKx8
	JXKdFWp1TgbiFT9/3QULIoOGJIkkoov9b4+J8J3sW0aWCoYmI0VR1DimBMPHzXOF
	mvzuzdhFoKmivrbfcyYI5X6uB5syuzxNIerJikZmjNgJeLOQxef7OJqNovaxPaJF
	XSDYEAhq6CLsx2wNr3TWRcM3iwMD9IQkIq1ShleA33w/ElYmOso+kA/y5qQjDoj8
	SbzBhQ==
Received: from mail-pj1-f72.google.com (mail-pj1-f72.google.com [209.85.216.72])
	by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 46pjm4qjyk-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128 verify=NOT)
	for <stable@vger.kernel.org>; Tue, 20 May 2025 12:30:58 +0000 (GMT)
Received: by mail-pj1-f72.google.com with SMTP id 98e67ed59e1d1-30c9b0aa4ccso5375597a91.3
        for <stable@vger.kernel.org>; Tue, 20 May 2025 05:30:58 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1747744257; x=1748349057;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=rXBDW4Zj2qm1riop642/edycQKRUKMuQeCUhQ63b6q8=;
        b=aYQqN0i0DkULE2+9z38dGApc+4ZhxkXLS8tFaI51mW5PZldJ7J4rY0PvEEf+vd9/xd
         lT+fugxzm2t2TMZcn4S4NVLL2nQ9SGtoU/aBoJGNf00pZO4xNarf4ZVtRtfrMIR7oHBw
         N+9mfoH6uESJcH3bWGPFMT3971lDmDunJ/KbzIes/I4NewmKWJQVaglC+bKuc0fSzOa0
         rjrjND9uXqQgbWq7TKygjS1oklGe6cSjJKXjoVmc0k0DPm7wLnbfZna27xWRBUOCtq0j
         xo93FGoji++uI5sgu6v4k0yD0SyilFVOHtQBBnKBU02+Ez6IhQmvnWVFOUbZKx7oTjx0
         p0nQ==
X-Forwarded-Encrypted: i=1; AJvYcCWlUqCTMLPwEFXjkpqZqWRAHSmivHxOcVvuni0olsNhnIKQnVZvlms4LbNvQFeT9h5pBH2Qt+g=@vger.kernel.org
X-Gm-Message-State: AOJu0YwTyvkLVOzV8OEJ/8ozR2EFbZYqw/IGredPwM4Ou3U7S2lCSvH5
	lKjvoE2aDh9eav8dRKB3VOQ5lzkYOEZGXdmHQv0GbBuGloOOsNgqV5VDSNBjz0T+/WO2eouA3Fi
	H5EBjCZCHCgUQBTqrw7lPIK8e84OY9VB5ozf1V4fnPfdMhInWLh3Bj3lOeMLpmiqpFKwJ65zLo5
	dAp/cX8jU/JTA1QmWRalUONF9H1s6jSZRWgw==
X-Gm-Gg: ASbGncslrlLXzCYEjOzaasAly66/gDbzLgX51WNqTrq5ZI4en7rPUMxtSeb4Lfug9Qz
	Z9U6xelk0SEX8ndn5XP98DxpBGym09cr1yhVIaVJ5lESdGwkidS9qB/mLZ0xlIzQGS+58jg==
X-Received: by 2002:a17:90b:5251:b0:308:5273:4dee with SMTP id 98e67ed59e1d1-30e7d542b40mr25042993a91.15.1747744256977;
        Tue, 20 May 2025 05:30:56 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IG7LERFtBGK7AEaAksZZ5SwMMPuSxqQKo8q2KlrpzNtpoBMKejcFG+jY35m4O/WHIROL/D8IyAak0xNsIBjlSM=
X-Received: by 2002:a17:90b:5251:b0:308:5273:4dee with SMTP id
 98e67ed59e1d1-30e7d542b40mr25042930a91.15.1747744256579; Tue, 20 May 2025
 05:30:56 -0700 (PDT)
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20250517043942.372315-1-royluo@google.com> <8f023425-3f9b-423c-9459-449d0835c608@linux.intel.com>
 <CAMTwNXB0QLP-b=RmLPtRJo=T_efN_3H4dd5AiMNYrJDXddJkMA@mail.gmail.com> <20250520003201.57f12dff@foxbook>
In-Reply-To: <20250520003201.57f12dff@foxbook>
From: Udipto Goswami <udipto.goswami@oss.qualcomm.com>
Date: Tue, 20 May 2025 18:00:44 +0530
X-Gm-Features: AX0GCFv2SiJ3q2jRbyIfdSpQtz2ju4Vl5p2bc-eQmtKh68-w0TJPHdu1d6PX364
Message-ID: <CAMTwNXBkAVjwaERAu-UHEHmH-BNe7T3iRfntLw+076g1OWgrPA@mail.gmail.com>
Subject: Re: [PATCH v1] Revert "usb: xhci: Implement xhci_handshake_check_state()
 helper"
To: =?UTF-8?Q?Micha=C5=82_Pecio?= <michal.pecio@gmail.com>
Cc: Mathias Nyman <mathias.nyman@linux.intel.com>, Roy Luo <royluo@google.com>,
        mathias.nyman@intel.com, quic_ugoswami@quicinc.com,
        Thinh.Nguyen@synopsys.com, gregkh@linuxfoundation.org,
        linux-usb@vger.kernel.org, linux-kernel@vger.kernel.org,
        stable@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
X-Proofpoint-ORIG-GUID: unNIp26Fp87b5HXEPIzOAmJIxUOi5yds
X-Authority-Analysis: v=2.4 cv=C4bpyRP+ c=1 sm=1 tr=0 ts=682c7602 cx=c_pps
 a=RP+M6JBNLl+fLTcSJhASfg==:117 a=IkcTkHD0fZMA:10 a=dt9VzEwgFbYA:10
 a=VwQbUJbxAAAA:8 a=COk6AnOGAAAA:8 a=pGLkceISAAAA:8 a=TLaf8UyukAPKd0nM82IA:9
 a=QEXdDO2ut3YA:10 a=iS9zxrgQBfv6-_F4QbHw:22 a=TjNXssC_j7lpFel5tvFf:22
X-Proofpoint-GUID: unNIp26Fp87b5HXEPIzOAmJIxUOi5yds
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjUwNTIwMDEwMCBTYWx0ZWRfX0VXJBYoYtXJA
 sCOkI7J7rSiBwj7uuj/ppQ/ZAGHFl00X48AUNm66V0sZj8oAzEbxdANFevjU950GO4gc/u1KmXN
 CQ9mi2oedc7RObeyIdvzE7Sp56ghlpBHM+UZoJhqIMd8ctrycSu0M4SSXGKLA2DdhAIYSAhxCne
 7aucia1XCsazRfZ58FWgBF7HU+4IPlxMA5cTFlohlfr5FVUEmYZ4WT8H2soqwyktZe9scke4FRK
 oo07S3sONH+0JIctqEZ4TQCs0/7y+rs4W1nu0v/72JAn718gwzNCa5g5IGYX3wbq0VUKP3fwtNw
 kY/gtu8HjxQykz60lazILBgIN6d7b6+2QBi2KA/M0l8DVl/83WJDwqTe0H2KdhvcBOTca1rLSfj
 3bZVzb1W+CS/fLecj7Hi9OOV8+K4mDPsIrdA1dCMCCaRC8Do1cNO8wdknrOIxSOGrwRWkemR
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1099,Hydra:6.0.736,FMLib:17.12.80.40
 definitions=2025-05-20_05,2025-05-16_03,2025-03-28_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 priorityscore=1501 malwarescore=0 suspectscore=0 impostorscore=0 adultscore=0
 mlxlogscore=999 spamscore=0 lowpriorityscore=0 phishscore=0 mlxscore=0
 bulkscore=0 clxscore=1015 classifier=spam authscore=0 authtc=n/a authcc=
 route=outbound adjust=0 reason=mlx scancount=1 engine=8.19.0-2505070000
 definitions=main-2505200100

On Tue, May 20, 2025 at 4:02=E2=80=AFAM Micha=C5=82 Pecio <michal.pecio@gma=
il.com> wrote:
>
> On Mon, 19 May 2025 23:43:21 +0530, Udipto Goswami wrote:
> > Hi Mathias,
> >
> > From what I recall, we saw this issue coming up on our QCOM mobile
> > platforms but it was not consistent. It was only reported in long runs
> > i believe. The most recent instance when I pushed this patch was with
> > platform SM8650, it was a watchdog timeout issue where xhci_reset() ->
> > xhci_handshake() polling read timeout upon xhci remove.
>
> Was it some system-wide watchdog, i.e. unrelated tasks were locking up?
Hi Michal,
Not exactly, I could see the other tasks were not stuck, only the
readl which we do as part of xhci_handshake with a 10 sec timer.
Our watchdog barks out at 10 sec and we saw in that timeframe it
didn't respond i.e the readl_poll_timeout_atomic  was still polling.
Since the timer is exactly aligned to the Watchdog timer here
therefore it crashed.


> It looks similar to that command abort freeze: xhci_resume() calls
> xhci_reset() under xhci->lock, and xhci_handshake() spins for a few
> seconds with the spinlock held. Anything else (workers, IRQs) trying
> to grab the lock will also spin and delay unrelated things.
>
> Not sure why your commit message says "Use this helper in places where
> xhci_handshake is called unlocked and has a long timeout", because you
> end up calling it from two places where the lock is (incorrectly) held.
> That's why adding the early bailout helped, I guess.
>
I think we had re-worded the patch a little, this was my original commit:

"In some situations where xhci removal happens parallel to
xhci_handshake, we enoughter a scenario where the xhci_handshake will
fails because the status does not change the entire duration of
polling. This causes the xhci_handshake to timeout resulting in long
wait which might lead to watchdog timeout." The API  handles command
timeout which may happen upon XHCI stack removal. Check for xhci state
and exit the handshake if xhci is removed.
https://lore.kernel.org/all/20230919085847.8210-1-quic_ugoswami@quicinc.com=
/

But yeah the main motive was to bail out handshake to get around this.

So you could say my main problem was that the CMD_RESET was stuck for
a long time.
In other cases the reset passes in very short amount of time. It was
unusual for this case.

> > Unfortunately I was not able to simulate the scenario for more
> > granular testing and had validated it with long hours stress testing.
>
> Looking at xhci_resume(), it will call xhci_reset() if the controller
> has known bugs (e.g. the RESET_ON_RESUME quirk) or it fails resuming.
>
> I guess you could simulate this case by forcing the quirk with a module
> parameter and adding some extra delay to xhci_handshake(), so you are
> not dependent on the hardware actually failing in any manner.

This would definitely bark, but like I mentioned my case was that the
CMD_RESET didn't exit the poll in the 10 sec.
I'm not sure if that points to the controller stuck at processing
something else?
Please correct me if i'm wrong here.

Thanks,
-Udipto

