Return-Path: <stable+bounces-69454-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 29E099564B9
	for <lists+stable@lfdr.de>; Mon, 19 Aug 2024 09:33:08 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 4C9DB1C208B2
	for <lists+stable@lfdr.de>; Mon, 19 Aug 2024 07:33:07 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id E0AC5157490;
	Mon, 19 Aug 2024 07:33:01 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="RY5C4ZbR"
X-Original-To: stable@vger.kernel.org
Received: from mail-pf1-f173.google.com (mail-pf1-f173.google.com [209.85.210.173])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1075C13C8E8
	for <stable@vger.kernel.org>; Mon, 19 Aug 2024 07:32:59 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.210.173
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1724052781; cv=none; b=B7UvJCbp9yDx+YP8aAgPs7fP9Bta+4lVW2LU0XFiiHr4Kahu0HhqkvqYrPLFXv0wLm/9OJCU6BkdPtAbqZBRbUUc0tH9mmLtEVshkz3tvzvobUeubwUKDi39iPLrbtjlMQpoDA0JJgPUdmP7Aa1NmhT8HjVvf624bg+zMp2eUB4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1724052781; c=relaxed/simple;
	bh=lqG59gpccqoJniQbhLyFTrxHLnQRRH2XLMNU6pCm0bc=;
	h=Date:From:To:CC:Subject:In-Reply-To:References:Message-ID:
	 MIME-Version:Content-Type; b=Ia/nw+05LQbQSrpOp0VDNDdf/LkmuohhOaXawV2mOxZcy3lYaC9o0pkHgJYCu0/i0/VWStASEDBHQJNQnu/GiQ1fDLlbaUZjA6eF49P5DNdrbiuNEKBkvYSXthA7t5ffbb8zx/+R+CVcoCLDz3Zw6hToAAum+Q0GYaE4ESQ9khM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org; spf=pass smtp.mailfrom=linaro.org; dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b=RY5C4ZbR; arc=none smtp.client-ip=209.85.210.173
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linaro.org
Received: by mail-pf1-f173.google.com with SMTP id d2e1a72fcca58-710ffaf921fso2552459b3a.1
        for <stable@vger.kernel.org>; Mon, 19 Aug 2024 00:32:59 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1724052779; x=1724657579; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:references
         :in-reply-to:user-agent:subject:cc:to:from:date:from:to:cc:subject
         :date:message-id:reply-to;
        bh=bVF+vaplgIfDeqn8Jo/FGo4c3zDJgnAYKY22inJTgUE=;
        b=RY5C4ZbRSr/qdLgu8HKFVmN4ewPDru+AGNit5VwvKAv2yzJ5q/1Cn2JD4O0PoDzNrg
         n4Y17grSMdalKiNcQRoGY1BotaeUwRikPBKihx1dg8/kOI8cFFQ7cOINwIcQcwPz6OUe
         JNHcgWqnG+vI0WGZTfC1te5jTgr/+qvUVyEATPyvbOQGd2Y8MIy076rdQCJELXEDZaEl
         AhvDkVIut86r7ZILIBCWT9YqXW6hPQkuDOqNNRV8BCl6ppyolhV+DCukv+7kG1dJzlx1
         ClnUL3F4dioS4qYew83d7I4Hns6b9mVujnudIg2oIyPPq0kpxc2NDFIapVoLxFCmEsRb
         E10g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1724052779; x=1724657579;
        h=content-transfer-encoding:mime-version:message-id:references
         :in-reply-to:user-agent:subject:cc:to:from:date:x-gm-message-state
         :from:to:cc:subject:date:message-id:reply-to;
        bh=bVF+vaplgIfDeqn8Jo/FGo4c3zDJgnAYKY22inJTgUE=;
        b=U3JS/4eV0Cki06GfO69yAeRxa5BgCY0552kwXscFieZLA3VLX+eKTd1ZlxeFftJuBx
         VBydFXXhfGz4h3/e0BRYUkbSWHJ+xJ2XtN2oSuxnMOksLPX9JGshGDUGzgDU1B7tKdTr
         Z14sRav3yjprtr2s/16umTN3V8yrK0nvtmJexQ9JsTnY6zSpOfrxEqLkJHm4SDIL/N92
         KSWIXpcemDyODxG0Kvm0sQKZrpiW4boJVBJaLc4KtfndAufVMMtbfl7DSDFuWPe53T9V
         JpimbfMGOApBaLBqMqsxznGNnDdYi6TOzc+pzncD7yO/whpzZ4MMy63vfatftp9mdEcy
         QL3g==
X-Forwarded-Encrypted: i=1; AJvYcCXlxD0LSfQDLc5thcLePL9vJdY3kHZ7MNjQVfizpxMVvC48AQkWaT9ekyIql8vW8P+zktdKXlLPdZdthgN7YAMRZq9z9lFj
X-Gm-Message-State: AOJu0YwhzeRxzj8DcUEQlI8zziTRHdEMP21U33nViNVQBqqAQYu/i3uW
	h4tzTwlnAY4z1InSZr+LyhZpu+x7fvLhA5Ov2l6tVGYgf/D3HHWAuLttzGncSwE=
X-Google-Smtp-Source: AGHT+IFfm2w3BSOecH3ZgllW9SAhYMQsRd/FMRvM7RHDXRP2ro3rXfQFvLQQyRy2k8EZr/AD4ObC6g==
X-Received: by 2002:a05:6a00:17a7:b0:70e:98e2:c76e with SMTP id d2e1a72fcca58-713c66515f1mr15127310b3a.6.1724052779034;
        Mon, 19 Aug 2024 00:32:59 -0700 (PDT)
Received: from ?IPv6:::1? ([2405:9800:b900:a564:77f2:b46a:c9f8:ca95])
        by smtp.gmail.com with ESMTPSA id d2e1a72fcca58-7127aef5787sm6111501b3a.120.2024.08.19.00.32.57
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Mon, 19 Aug 2024 00:32:58 -0700 (PDT)
Date: Mon, 19 Aug 2024 14:32:53 +0700
From: Dmitry Baryshkov <dmitry.baryshkov@linaro.org>
To: Bjorn Andersson <quic_bjorande@quicinc.com>
CC: Sebastian Reichel <sre@kernel.org>, Bjorn Andersson <andersson@kernel.org>,
 Konrad Dybcio <konrad.dybcio@linaro.org>,
 Heikki Krogerus <heikki.krogerus@linux.intel.com>,
 Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
 Neil Armstrong <neil.armstrong@linaro.org>,
 Johan Hovold <johan+linaro@kernel.org>, Chris Lew <quic_clew@quicinc.com>,
 Stephen Boyd <swboyd@chromium.org>, Amit Pundir <amit.pundir@linaro.org>,
 linux-arm-msm@vger.kernel.org, linux-pm@vger.kernel.org,
 linux-kernel@vger.kernel.org, linux-usb@vger.kernel.org,
 stable@vger.kernel.org
Subject: =?US-ASCII?Q?Re=3A_=5BPATCH_2/3=5D_usb=3A_typec=3A_ucsi=3A_M?=
 =?US-ASCII?Q?ove_unregister_out_of_atomic_section?=
User-Agent: K-9 Mail for Android
In-Reply-To: <ZsK2jSheqBlCW7OC@hu-bjorande-lv.qualcomm.com>
References: <20240818-pmic-glink-v6-11-races-v1-0-f87c577e0bc9@quicinc.com> <20240818-pmic-glink-v6-11-races-v1-2-f87c577e0bc9@quicinc.com> <4F313FA4-C2C7-4BD8-8E42-64F98EACCBA2@linaro.org> <ZsK2jSheqBlCW7OC@hu-bjorande-lv.qualcomm.com>
Message-ID: <A366AFBC-1775-421A-BEAC-274741DF3192@linaro.org>
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain;
 charset=utf-8
Content-Transfer-Encoding: quoted-printable

On 19 August 2024 10:05:49 GMT+07:00, Bjorn Andersson <quic_bjorande@quicin=
c=2Ecom> wrote:
>On Mon, Aug 19, 2024 at 08:16:25AM +0700, Dmitry Baryshkov wrote:
>> On 19 August 2024 06:17:38 GMT+07:00, Bjorn Andersson <quic_bjorande@qu=
icinc=2Ecom> wrote:
>> >Commit 'caa855189104 ("soc: qcom: pmic_glink: Fix race during
>> >initialization")' moved the pmic_glink client list under a spinlock, a=
s
>> >it is accessed by the rpmsg/glink callback, which in turn is invoked
>> >from IRQ context=2E
>> >
>> >This means that ucsi_unregister() is now called from IRQ context, whic=
h
>> >isn't feasible as it's expecting a sleepable context=2E An effort is u=
nder
>> >way to get GLINK to invoke its callbacks in a sleepable context, but
>> >until then lets schedule the unregistration=2E
>> >
>> >A side effect of this is that ucsi_unregister() can now happen
>> >after the remote processor, and thereby the communication link with it=
, is
>> >gone=2E pmic_glink_send() is amended with a check to avoid the resulti=
ng
>> >NULL pointer dereference, but it becomes expecting to see a failing se=
nd
>> >upon shutting down the remote processor (e=2Eg=2E during a restart fol=
lowing
>> >a firmware crash):
>> >
>> >  ucsi_glink=2Epmic_glink_ucsi pmic_glink=2Eucsi=2E0: failed to send U=
CSI write request: -5
>> >
>> >Fixes: caa855189104 ("soc: qcom: pmic_glink: Fix race during initializ=
ation")
>> >Cc: stable@vger=2Ekernel=2Eorg
>> >Signed-off-by: Bjorn Andersson <quic_bjorande@quicinc=2Ecom>
>> >---
>> > drivers/soc/qcom/pmic_glink=2Ec       | 10 +++++++++-
>> > drivers/usb/typec/ucsi/ucsi_glink=2Ec | 28 +++++++++++++++++++++++---=
--
>> > 2 files changed, 32 insertions(+), 6 deletions(-)
>> >
>> >diff --git a/drivers/soc/qcom/pmic_glink=2Ec b/drivers/soc/qcom/pmic_g=
link=2Ec
>> >index 58ec91767d79=2E=2Ee4747f1d3da5 100644
>> >--- a/drivers/soc/qcom/pmic_glink=2Ec
>> >+++ b/drivers/soc/qcom/pmic_glink=2Ec
>> >@@ -112,8 +112,16 @@ EXPORT_SYMBOL_GPL(pmic_glink_register_client);
>> > int pmic_glink_send(struct pmic_glink_client *client, void *data, siz=
e_t len)
>> > {
>> > 	struct pmic_glink *pg =3D client->pg;
>> >+	int ret;
>> >=20
>> >-	return rpmsg_send(pg->ept, data, len);
>> >+	mutex_lock(&pg->state_lock);
>> >+	if (!pg->ept)
>> >+		ret =3D -ECONNRESET;
>> >+	else
>> >+		ret =3D rpmsg_send(pg->ept, data, len);
>> >+	mutex_unlock(&pg->state_lock);
>> >+
>> >+	return ret;
>> > }
>> > EXPORT_SYMBOL_GPL(pmic_glink_send);
>> >=20
>> >diff --git a/drivers/usb/typec/ucsi/ucsi_glink=2Ec b/drivers/usb/typec=
/ucsi/ucsi_glink=2Ec
>> >index ac53a81c2a81=2E=2Ea33056eec83d 100644
>> >--- a/drivers/usb/typec/ucsi/ucsi_glink=2Ec
>> >+++ b/drivers/usb/typec/ucsi/ucsi_glink=2Ec
>> >@@ -68,6 +68,9 @@ struct pmic_glink_ucsi {
>> >=20
>> > 	struct work_struct notify_work;
>> > 	struct work_struct register_work;
>> >+	spinlock_t state_lock;
>> >+	unsigned int pdr_state;
>> >+	unsigned int new_pdr_state;
>> >=20
>> > 	u8 read_buf[UCSI_BUF_SIZE];
>> > };
>> >@@ -244,8 +247,22 @@ static void pmic_glink_ucsi_notify(struct work_st=
ruct *work)
>> > static void pmic_glink_ucsi_register(struct work_struct *work)
>> > {
>> > 	struct pmic_glink_ucsi *ucsi =3D container_of(work, struct pmic_glin=
k_ucsi, register_work);
>> >+	unsigned long flags;
>> >+	unsigned int new_state;
>> >+
>> >+	spin_lock_irqsave(&ucsi->state_lock, flags);
>> >+	new_state =3D ucsi->new_pdr_state;
>> >+	spin_unlock_irqrestore(&ucsi->state_lock, flags);
>> >+
>> >+	if (ucsi->pdr_state !=3D SERVREG_SERVICE_STATE_UP) {
>> >+		if (new_state =3D=3D SERVREG_SERVICE_STATE_UP)
>> >+			ucsi_register(ucsi->ucsi);
>> >+	} else {
>> >+		if (new_state =3D=3D SERVREG_SERVICE_STATE_DOWN)
>> >+			ucsi_unregister(ucsi->ucsi);
>> >+	}
>> >=20
>> >-	ucsi_register(ucsi->ucsi);
>> >+	ucsi->pdr_state =3D new_state;
>> > }
>>=20
>> Is there a chance if a race condition if the firmware is restarted quic=
kly, but the system is under heavy mist:=20
>> - the driver gets DOWN event, updates the state and schedules the work,
>> - the work starts to execute, reads the state,
>> - the driver gets UP event, updates the state, but the work is not resc=
heduled as it is still executing=20
>> - the worker finishes unregistering the UCSI=2E
>>=20
>
>I was under the impression that if we reach the point where we start
>executing the worker, then a second schedule_work() would cause the
>worker to run again=2E But I might be mistaken here=2E

I don't have full source code at hand and the docs only speak about being =
queued, so it is perfectly possible that I am mistaken here=2E

>
>What I do expect though is that if we for some reason don't start
>executing the work before the state becomes UP again, the UCSI core
>wouldn't know that the firmware has been reset=2E
>
>
>My proposal is to accept this risk for v6=2E11 (and get the benefit of
>things actually working) and then take a new swing at getting rid of all
>these workers for v6=2E12/13=2E Does that sound reasonable?


Yes, makes sense to me=2E=20

Reviewed-by: Dmitry Baryshkov <dmitry=2Ebaryshkov@linaro=2Eorg>


>
>Regards,
>Bjorn
>
>>=20
>>=20
>> >=20
>> > static void pmic_glink_ucsi_callback(const void *data, size_t len, vo=
id *priv)
>> >@@ -269,11 +286,12 @@ static void pmic_glink_ucsi_callback(const void =
*data, size_t len, void *priv)
>> > static void pmic_glink_ucsi_pdr_notify(void *priv, int state)
>> > {
>> > 	struct pmic_glink_ucsi *ucsi =3D priv;
>> >+	unsigned long flags;
>> >=20
>> >-	if (state =3D=3D SERVREG_SERVICE_STATE_UP)
>> >-		schedule_work(&ucsi->register_work);
>> >-	else if (state =3D=3D SERVREG_SERVICE_STATE_DOWN)
>> >-		ucsi_unregister(ucsi->ucsi);
>> >+	spin_lock_irqsave(&ucsi->state_lock, flags);
>> >+	ucsi->new_pdr_state =3D state;
>> >+	spin_unlock_irqrestore(&ucsi->state_lock, flags);
>> >+	schedule_work(&ucsi->register_work);
>> > }
>> >=20
>> > static void pmic_glink_ucsi_destroy(void *data)
>> >
>>=20


