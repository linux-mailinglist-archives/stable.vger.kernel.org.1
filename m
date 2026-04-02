Return-Path: <stable+bounces-232929-lists+stable=lfdr.de@vger.kernel.org>
Delivered-To: lists+stable@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id KMyNCoQkzmnElAYAu9opvQ
	(envelope-from <stable+bounces-232929-lists+stable=lfdr.de@vger.kernel.org>)
	for <lists+stable@lfdr.de>; Thu, 02 Apr 2026 10:10:44 +0200
X-Original-To: lists+stable@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [172.234.253.10])
	by mail.lfdr.de (Postfix) with ESMTPS id 78A9C385A6A
	for <lists+stable@lfdr.de>; Thu, 02 Apr 2026 10:10:43 +0200 (CEST)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id 2E81C309D6A5
	for <lists+stable@lfdr.de>; Thu,  2 Apr 2026 08:04:16 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id EA5CD370D6F;
	Thu,  2 Apr 2026 08:04:15 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=broadcom.com header.i=@broadcom.com header.b="hSd45Ya9"
X-Original-To: stable@vger.kernel.org
Received: from mail-dy1-f227.google.com (mail-dy1-f227.google.com [74.125.82.227])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id F244738A71F
	for <stable@vger.kernel.org>; Thu,  2 Apr 2026 08:04:10 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=pass smtp.client-ip=74.125.82.227
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1775117055; cv=pass; b=bL6ePqTY2j4X6icX7T6BXS/ibGWIayQZODemrQBce2HEX4mLeCYPoxVqOrSHxEMm9clsc0u4M8qXq5pnqPpipPq0cJHYIK2L1CNwif02w9XTXWPRdSiuVIydZn6ZeBPHLigKaRLq4Mu+7J9PMsttblNvOzIFEppnX8bCxqeR20Y=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1775117055; c=relaxed/simple;
	bh=Gum6WgNl0Uk2XMgcp/VuFd6latqdAbvBEi/XwbJt/rI=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=NRp0EucCMNBV/FlNOpSIdCIm4fCV/7QbKK/WHJXB5ph6t3JQ12+wGxpb+PI50An1wnVzI2OqfUW9ntThY4ghNb+NQrSlY8mYbEMNzRiYTJ2UFfPAtU+mfdRWPi9pzEtacJHFJcymAPeMFSnwHwMm+UdQAiLYPfeXJS44Updytk8=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=broadcom.com; spf=fail smtp.mailfrom=broadcom.com; dkim=pass (1024-bit key) header.d=broadcom.com header.i=@broadcom.com header.b=hSd45Ya9; arc=pass smtp.client-ip=74.125.82.227
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=broadcom.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=broadcom.com
Received: by mail-dy1-f227.google.com with SMTP id 5a478bee46e88-2c5cf871adcso26533eec.1
        for <stable@vger.kernel.org>; Thu, 02 Apr 2026 01:04:10 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1775117050; x=1775721850;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:dkim-signature:x-gm-gg:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=C813iG1DovUgwciKzp6Hpslb2Ft8SvDUY8QXTDJ0680=;
        b=SxOCsGpAwpJu/odSwSrUHJTOcFcSWlJS6QTl1Ath94Vx0m5F/ieg0s0ZT4PYGqFkuU
         kW42bLchiZ32r1LJu9RjKiuLryeJaNgUXiWDxMMaDjfe6uvOWjcgqZA9WCVyyeKp6v04
         Btjc+P+QEfhjMHV3jw9SghQ2YDuroM4y9/yEVUso0/FnBl8PixgzbjJMt/1xPU/LXjGy
         HmjTulcbkoojoWTEAAUJOSK0Dum7/G5/HMKHxY0wTJHeQLUAJ3pHCBlr8IaYdvTQ+Xth
         eP/6W3/NFU5W/LN8ZC/CkP9tivr02ZY8w9OtfKryuqbvSUJZngOYJpOhNMVv95Gg6nN8
         pNpA==
X-Gm-Message-State: AOJu0YwouljyxQXc8WPalTrqiFj+YYu6+ne2odhmdKG863/SfCbR19hD
	w0GYTX+0f59mHXCuX4mBYgde98FsYsomFlU3z3hSx8TlmfbdHp1HdMn6Q7j0+7HruzlbxVxax48
	4URk6266DWaR5gLB3I0jl02KWBIakYSwNdxB7lSSqWE6iRI9tbX57eExTJjaa6yGEOoi0ejnqVl
	IIjDjvv7FQ/WmQoQxo9TzZhPFsXUmBXl5vvgwF4AVKXDC0394O/I1SgRiZoZkNWnAI83vreHw6Z
	6OO70dUfrhJH0R8IFSBTE53+egyjVU=
X-Gm-Gg: ATEYQzyMQC1I3p67FnErwuzkuxNY7ZKgBmwVBWAbtz6q3HU3I6MKDAWDMrATRM/gjiQ
	UrtCOLJ6y2JXDF/hDjAfVlFGL5e7yANzcoTAG0CPbOlxyR+zpO/UVbuLhg9LW119Qil4MD1VX/2
	O7qd9MD28RdR6LMMM73G6euArCnMASrvR7RVGaWJasCaS7dtJqXaNJKZwho6bLKiaixBZNnfWE8
	lD52c9vhJYlh/NNT6/b5THLB7pr0JbJcfzYzNrObW1sj4N7kRhLb2M/yIt/6hSVFI2dWMQg+2Az
	eNyre93g+DMeMqkbI0JYXGpRnxAHPVW7Nq9fpkqilVxHY5rat/8vU+gqa7R9/dMVhZnDkCwFIqI
	mpc5TLtO0G2F5RH2HRQrYN4PFeGjwvDwlApPwjHDjZVadzstk3NguMrumKCMXgQ0IUCeRnLu1Wo
	VfyQrmIzJ2uQ8mGCJpoXS3gbJQUjdxkUSidLnM4uXvcfx1PuIMZghPFBzFN79PSnlKg4l5952lS
	g==
X-Received: by 2002:a05:7300:7fa4:b0:2be:298c:a11 with SMTP id 5a478bee46e88-2c9321b8915mr1618000eec.3.1775117049680;
        Thu, 02 Apr 2026 01:04:09 -0700 (PDT)
Received: from smtp-us-east1-p01-i01-si01.dlp.protect.broadcom.com (address-144-49-247-15.dlp.protect.broadcom.com. [144.49.247.15])
        by smtp-relay.gmail.com with ESMTPS id 5a478bee46e88-2cb430fcfbasm28763eec.9.2026.04.02.01.04.09
        for <stable@vger.kernel.org>
        (version=TLS1_2 cipher=ECDHE-ECDSA-AES128-GCM-SHA256 bits=128/128);
        Thu, 02 Apr 2026 01:04:09 -0700 (PDT)
X-Relaying-Domain: broadcom.com
X-CFilter-Loop: Reflected
Received: by mail-ej1-f69.google.com with SMTP id a640c23a62f3a-b9bfabc058bso845166b.0
        for <stable@vger.kernel.org>; Thu, 02 Apr 2026 01:04:08 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; t=1775117047; cv=none;
        d=google.com; s=arc-20240605;
        b=HpAZZambSIxXz1NkYZYQBFhnuuvonkBGfym22ryuKE1+0BhiF9YeDyiAyXqC1uYJlx
         Mppg1cTJ1s4USRcC9L6Zdduzcmww6lzkx5YoO8h6YlzgbljRHROzbksSAYLn9ybvCV9D
         NJqF2QrmPTMOQ/KoSENwdv536LnH+5gte6lTziyj9aJItfecKlZotkbL43zUVY11xU+Q
         hPVamhDeQGFFGaSYY8k79jLTsLoxuSXGcdtxvn8LGNpoMLKSr/cGGMAij04GPNPJnCNH
         n5ljq2/SUNTgoS2GwQOzU3kiJSCIAHoVqxDHiGcfbnmvMiWCGblg9iSt3ryH4M5X6sWo
         AoZw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20240605;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:dkim-signature;
        bh=C813iG1DovUgwciKzp6Hpslb2Ft8SvDUY8QXTDJ0680=;
        fh=Q6yr1wV2iPA4BdMeZHWNL4SAcQXEztnOJRglrx2BKeQ=;
        b=Sa5WbzEAc6Rq0aJOaqRQy7Yepl92jChHEG45QmTe+Mu5b5mi0sAEYuBmwxNk3r5wyg
         bFJ9TaZrmjzCm9fqzl8hW+Pi/wbAiHi1NINVnoqM3/zPolfEsCYuhgnv9YzaKIUkQlNE
         c3o3N8uav/6Y5rUjrKwK5PEMW/WJEPVmPhY28jmJly771VABmzjhKhx4p5WuUA9KMYeG
         QqmRsRO4vPbwp7aHw9Av2mlHRkmSM9gHG5wcU2DzqX5D6mp/6eIorWli/uGtX+y/xYar
         lrNiJ9YWNkvziWiFbFVYbbD/BjYYueG80RAlWFKo/RHFXEOhArRzmuoLzKdSzvlTOZbo
         PB4A==;
        darn=vger.kernel.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=broadcom.com; s=google; t=1775117047; x=1775721847; darn=vger.kernel.org;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:from:to:cc:subject:date:message-id:reply-to;
        bh=C813iG1DovUgwciKzp6Hpslb2Ft8SvDUY8QXTDJ0680=;
        b=hSd45Ya9/ZnXFLbNw9W4jj3gtEYlvgg5yxjRgYVgN6W0AfNyHpABrh85jHLiP24upF
         DC86rmz1Co1Vfme0Dk5o/AfGU1vn+5sacuIvrAGTuSiCw7mUvtLdOblepwOGjnbD9w0l
         vjJw5XTMhZTKg4CuQdcBwft1AEqHM4gOUsY2c=
X-Received: by 2002:a05:6402:1471:b0:669:cbd2:255f with SMTP id 4fb4d7f45d1cf-66daf429735mr1738403a12.0.1775117046969;
        Thu, 02 Apr 2026 01:04:06 -0700 (PDT)
X-Received: by 2002:a05:6402:1471:b0:669:cbd2:255f with SMTP id
 4fb4d7f45d1cf-66daf429735mr1738395a12.0.1775117046408; Thu, 02 Apr 2026
 01:04:06 -0700 (PDT)
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20260402054700.2798707-1-keerthana.kalyanasundaram@broadcom.com> <2026040249-fable-sasquatch-4864@gregkh>
In-Reply-To: <2026040249-fable-sasquatch-4864@gregkh>
From: Keerthana Kalyanasundaram <keerthana.kalyanasundaram@broadcom.com>
Date: Thu, 2 Apr 2026 13:33:53 +0530
X-Gm-Features: AQROBzC1l89xjx-SwbO4Ed504ZoHRVoiKpM_Bu_SvADGU2RpJo0ZqqhjPoiJG-M
Message-ID: <CAM8uoQ8z6oUBi20uRPrn=xuX05aHp7Pf26Q_R88scCmQ4Ma+=Q@mail.gmail.com>
Subject: Re: [PATCH v6.1] apparmor: fix unprivileged local user can do
 privileged policy management
To: Greg KH <gregkh@linuxfoundation.org>
Cc: stable@vger.kernel.org, john.johansen@canonical.com, paul@paul-moore.com, 
	jmorris@namei.org, serge@hallyn.com, georgia.garcia@canonical.com, 
	cengiz.can@canonical.com, sashal@kernel.org, apparmor@lists.ubuntu.com, 
	linux-security-module@vger.kernel.org, linux-kernel@vger.kernel.org, 
	ajay.kaher@broadcom.com, alexey.makhalov@broadcom.com, 
	vamsi-krishna.brahmajosyula@broadcom.com, yin.ding@broadcom.com, 
	tapas.kundu@broadcom.com, Qualys Security Advisory <qsa@qualys.com>, 
	Salvatore Bonaccorso <carnil@debian.org>
X-DetectorID-Processed: b00c1d49-9d2e-4205-b15f-d015386d3d5e
Content-Type: multipart/signed; protocol="application/pkcs7-signature"; micalg=sha-256;
	boundary="0000000000000ca1b8064e75a55d"
X-Spamd-Result: default: False [-4.26 / 15.00];
	SIGNED_SMIME(-2.00)[];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=2];
	DMARC_POLICY_ALLOW(-0.50)[broadcom.com,reject];
	R_DKIM_ALLOW(-0.20)[broadcom.com:s=google];
	R_SPF_ALLOW(-0.20)[+ip4:172.234.253.10:c];
	MIME_GOOD(-0.20)[multipart/signed,multipart/alternative,text/plain];
	MAILLIST(-0.15)[generic];
	HAS_LIST_UNSUB(-0.01)[];
	TAGGED_FROM(0.00)[bounces-232929-lists,stable=lfdr.de];
	RCVD_TLS_LAST(0.00)[];
	FROM_HAS_DN(0.00)[];
	FORGED_SENDER_MAILLIST(0.00)[];
	RCPT_COUNT_TWELVE(0.00)[19];
	MIME_TRACE(0.00)[0:+,1:+,2:+,3:~,4:~];
	TO_DN_SOME(0.00)[];
	DKIM_TRACE(0.00)[broadcom.com:+];
	MISSING_XM_UA(0.00)[];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[keerthana.kalyanasundaram@broadcom.com,stable@vger.kernel.org];
	HAS_ATTACHMENT(0.00)[];
	RCVD_COUNT_FIVE(0.00)[6];
	TAGGED_RCPT(0.00)[stable];
	NEURAL_HAM(-0.00)[-1.000];
	ASN(0.00)[asn:63949, ipnet:172.234.224.0/19, country:SG];
	DBL_BLOCKED_OPENRESOLVER(0.00)[broadcom.com:dkim,canonical.com:email,mail.gmail.com:mid,linuxfoundation.org:email,sea.lore.kernel.org:helo,sea.lore.kernel.org:rdns]
X-Rspamd-Queue-Id: 78A9C385A6A
X-Rspamd-Action: no action
X-Rspamd-Server: lfdr

--0000000000000ca1b8064e75a55d
Content-Type: multipart/alternative; boundary="000000000000fcf20a064e75a474"

--000000000000fcf20a064e75a474
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Thu, Apr 2, 2026 at 11:31=E2=80=AFAM Greg KH <gregkh@linuxfoundation.org=
> wrote:

> On Thu, Apr 02, 2026 at 05:47:00AM +0000, Keerthana K wrote:
> > From: John Johansen <john.johansen@canonical.com>
> >
> > commit 6601e13e82841879406bf9f369032656f441a425 upstream.
>
> <snip>
>
> Does your group/company/whatever actually use apparmor?  If so, this
> isn't the only commit that needs to be backported.  I'm waiting on a
> "correct" set of 6.1.y patches from John before applying all of them to
> 6.1.y and then I can take the patch series that he gave me for 5.10.y
> and 5.15.y and will queue them up.
>
> So thanks for this backport, but it's not going to help resolve all of
> the recent fixes that went in as part of this series by just applying
> one of them.
>
> Thanks for the update, Greg. We will wait for John to queue and apply the
complete series of patches to the stable branches.

 thanks,
>
> greg k-h
>

--000000000000fcf20a064e75a474
Content-Type: text/html; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

<div dir=3D"ltr"><div dir=3D"ltr"><div><br></div></div><div class=3D"gmail_=
quote gmail_quote_container"><div dir=3D"ltr" class=3D"gmail_attr">On Thu, =
Apr 2, 2026 at 11:31=E2=80=AFAM Greg KH &lt;<a href=3D"mailto:gregkh@linuxf=
oundation.org">gregkh@linuxfoundation.org</a>&gt; wrote:<br></div><blockquo=
te class=3D"gmail_quote" style=3D"margin:0px 0px 0px 0.8ex;border-left:1px =
solid rgb(204,204,204);padding-left:1ex">On Thu, Apr 02, 2026 at 05:47:00AM=
 +0000, Keerthana K wrote:<br>
&gt; From: John Johansen &lt;<a href=3D"mailto:john.johansen@canonical.com"=
 target=3D"_blank">john.johansen@canonical.com</a>&gt;<br>
&gt; <br>
&gt; commit 6601e13e82841879406bf9f369032656f441a425 upstream.<br>
<br>
&lt;snip&gt;<br>
<br>
Does your group/company/whatever actually use apparmor?=C2=A0 If so, this<b=
r>
isn&#39;t the only commit that needs to be backported.=C2=A0 I&#39;m waitin=
g on a<br>
&quot;correct&quot; set of 6.1.y patches from John before applying all of t=
hem to<br>
6.1.y and then I can take the patch series that he gave me for 5.10.y<br>
and 5.15.y and will queue them up.<br>
<br>
So thanks for this backport, but it&#39;s not going to help resolve all of<=
br>
the recent fixes that went in as part of this series by just applying<br>
one of them.<br>
<br></blockquote><div><span class=3D"gmail_default" style=3D"font-family:ve=
rdana,sans-serif">Thanks for the update, Greg.=C2=A0</span><font face=3D"ve=
rdana, sans-serif">We will wait for John to queue and apply the complete se=
ries of patches to the stable branches.</font></div><p></p><blockquote clas=
s=3D"gmail_quote" style=3D"margin:0px 0px 0px 0.8ex;border-left:1px solid r=
gb(204,204,204);padding-left:1ex">=C2=A0thanks,<br>
<br>
greg k-h<br>
</blockquote></div></div>

--000000000000fcf20a064e75a474--

--0000000000000ca1b8064e75a55d
Content-Type: application/pkcs7-signature; name="smime.p7s"
Content-Transfer-Encoding: base64
Content-Disposition: attachment; filename="smime.p7s"
Content-Description: S/MIME Cryptographic Signature

MIIVTwYJKoZIhvcNAQcCoIIVQDCCFTwCAQExDzANBglghkgBZQMEAgEFADALBgkqhkiG9w0BBwGg
ghK8MIIGqDCCBJCgAwIBAgIQfofDCS7XZu8vIeKo0KeY9DANBgkqhkiG9w0BAQwFADBMMSAwHgYD
VQQLExdHbG9iYWxTaWduIFJvb3QgQ0EgLSBSNjETMBEGA1UEChMKR2xvYmFsU2lnbjETMBEGA1UE
AxMKR2xvYmFsU2lnbjAeFw0yMzA0MTkwMzUzNTNaFw0yOTA0MTkwMDAwMDBaMFIxCzAJBgNVBAYT
AkJFMRkwFwYDVQQKExBHbG9iYWxTaWduIG52LXNhMSgwJgYDVQQDEx9HbG9iYWxTaWduIEdDQyBS
NiBTTUlNRSBDQSAyMDIzMIICIjANBgkqhkiG9w0BAQEFAAOCAg8AMIICCgKCAgEAwjAEbSkPcSyn
26Zn9VtoE/xBvzYmNW29bW1pJZ7jrzKwPJm/GakCvy0IIgObMsx9bpFaq30X1kEJZnLUzuE1/hlc
hatYqyORVBeHlv5V0QRSXY4faR0dCkIhXhoGknZ2O0bUJithcN1IsEADNizZ1AJIaWsWbQ4tYEYj
ytEdvfkxz1WtX3SjtecZR+9wLJLt6HNa4sC//QKdjyfr/NhDCzYrdIzAssoXFnp4t+HcMyQTrj0r
pD8KkPj96sy9axzegLbzte7wgTHbWBeJGp0sKg7BAu+G0Rk6teO1yPd75arbCvfY/NaRRQHk6tmG
71gpLdB1ZhP9IcNYyeTKXIgfMh2tVK9DnXGaksYCyi6WisJa1Oa+poUroX2ESXO6o03lVxiA1xyf
G8lUzpUNZonGVrUjhG5+MdY16/6b0uKejZCLbgu6HLPvIyqdTb9XqF4XWWKu+OMDs/rWyQ64v3mv
Sa0te5Q5tchm4m9K0Pe9LlIKBk/gsgfaOHJDp4hYx4wocDr8DeCZe5d5wCFkxoGc1ckM8ZoMgpUc
4pgkQE5ShxYMmKbPvNRPa5YFzbFtcFn5RMr1Mju8gt8J0c+dxYco2hi7dEW391KKxGhv7MJBcc+0
x3FFTnmhU+5t6+CnkKMlrmzyaoeVryRTvOiH4FnTNHtVKUYDsCM0CLDdMNgoxgkCAwEAAaOCAX4w
ggF6MA4GA1UdDwEB/wQEAwIBhjBMBgNVHSUERTBDBggrBgEFBQcDAgYIKwYBBQUHAwQGCisGAQQB
gjcUAgIGCisGAQQBgjcKAwwGCisGAQQBgjcKAwQGCSsGAQQBgjcVBjASBgNVHRMBAf8ECDAGAQH/
AgEAMB0GA1UdDgQWBBQAKTaeXHq6D68tUC3boCOFGLCgkjAfBgNVHSMEGDAWgBSubAWjkxPioufi
1xzWx/B/yGdToDB7BggrBgEFBQcBAQRvMG0wLgYIKwYBBQUHMAGGImh0dHA6Ly9vY3NwMi5nbG9i
YWxzaWduLmNvbS9yb290cjYwOwYIKwYBBQUHMAKGL2h0dHA6Ly9zZWN1cmUuZ2xvYmFsc2lnbi5j
b20vY2FjZXJ0L3Jvb3QtcjYuY3J0MDYGA1UdHwQvMC0wK6ApoCeGJWh0dHA6Ly9jcmwuZ2xvYmFs
c2lnbi5jb20vcm9vdC1yNi5jcmwwEQYDVR0gBAowCDAGBgRVHSAAMA0GCSqGSIb3DQEBDAUAA4IC
AQCRkUdr1aIDRmkNI5jx5ggapGUThq0KcM2dzpMu314mJne8yKVXwzfKBtqbBjbUNMODnBkhvZcn
bHUStur2/nt1tP3ee8KyNhYxzv4DkI0NbV93JChXipfsan7YjdfEk5vI2Fq+wpbGALyyWBgfy79Y
IgbYWATB158tvEh5UO8kpGpjY95xv+070X3FYuGyeZyIvao26mN872FuxRxYhNLwGHIy38N9ASa1
Q3BTNKSrHrZngadofHglG5W3TMFR11JOEOAUHhUgpbVVvgCYgGA6dSX0y5z7k3rXVyjFOs7KBSXr
dJPKadpl4vqYphH7+P40nzBRcxJHrv5FeXlTrb+drjyXNjZSCmzfkOuCqPspBuJ7vab0/9oeNERg
nz6SLCjLKcDXbMbKcRXgNhFBlzN4OUBqieSBXk80w2Nzx12KvNj758WavxOsXIbX0Zxwo1h3uw75
AI2v8qwFWXNclO8qW2VXoq6kihWpeiuvDmFfSAwRLxwwIjgUuzG9SaQ+pOomuaC7QTKWMI0hL0b4
mEPq9GsPPQq1UmwkcYFJ/Z4I93DZuKcXmKMmuANTS6wxwIEw8Q5MQ6y9fbJxGEOgOgYL4QIqNULb
5CYPnt2LeiIiEnh8Uuh8tawqSjnR0h7Bv5q4mgo3L1Z9QQuexUntWD96t4o0q1jXWLyrpgP7Zcnu
CzCCBYMwggNroAMCAQICDkXmuwODM8OFZUjm/0VRMA0GCSqGSIb3DQEBDAUAMEwxIDAeBgNVBAsT
F0dsb2JhbFNpZ24gUm9vdCBDQSAtIFI2MRMwEQYDVQQKEwpHbG9iYWxTaWduMRMwEQYDVQQDEwpH
bG9iYWxTaWduMB4XDTE0MTIxMDAwMDAwMFoXDTM0MTIxMDAwMDAwMFowTDEgMB4GA1UECxMXR2xv
YmFsU2lnbiBSb290IENBIC0gUjYxEzARBgNVBAoTCkdsb2JhbFNpZ24xEzARBgNVBAMTCkdsb2Jh
bFNpZ24wggIiMA0GCSqGSIb3DQEBAQUAA4ICDwAwggIKAoICAQCVB+hzymb57BTKezz3DQjxtEUL
LIK0SMbrWzyug7hBkjMUpG9/6SrMxrCIa8W2idHGsv8UzlEUIexK3RtaxtaH7k06FQbtZGYLkoDK
RN5zlE7zp4l/T3hjCMgSUG1CZi9NuXkoTVIaihqAtxmBDn7EirxkTCEcQ2jXPTyKxbJm1ZCatzEG
xb7ibTIGph75ueuqo7i/voJjUNDwGInf5A959eqiHyrScC5757yTu21T4kh8jBAHOP9msndhfuDq
jDyqtKT285VKEgdt/Yyyic/QoGF3yFh0sNQjOvddOsqi250J3l1ELZDxgc1Xkvp+vFAEYzTfa5MY
vms2sjnkrCQ2t/DvthwTV5O23rL44oW3c6K4NapF8uCdNqFvVIrxclZuLojFUUJEFZTuo8U4lptO
TloLR/MGNkl3MLxxN+Wm7CEIdfzmYRY/d9XZkZeECmzUAk10wBTt/Tn7g/JeFKEEsAvp/u6P4W4L
sgizYWYJarEGOmWWWcDwNf3J2iiNGhGHcIEKqJp1HZ46hgUAntuA1iX53AWeJ1lMdjlb6vmlodiD
D9H/3zAR+YXPM0j1ym1kFCx6WE/TSwhJxZVkGmMOeT31s4zKWK2cQkV5bg6HGVxUsWW2v4yb3BPp
DW+4LtxnbsmLEbWEFIoAGXCDeZGXkdQaJ783HjIH2BRjPChMrwIDAQABo2MwYTAOBgNVHQ8BAf8E
BAMCAQYwDwYDVR0TAQH/BAUwAwEB/zAdBgNVHQ4EFgQUrmwFo5MT4qLn4tcc1sfwf8hnU6AwHwYD
VR0jBBgwFoAUrmwFo5MT4qLn4tcc1sfwf8hnU6AwDQYJKoZIhvcNAQEMBQADggIBAIMl7ejR/ZVS
zZ7ABKCRaeZc0ITe3K2iT+hHeNZlmKlbqDyHfAKK0W63FnPmX8BUmNV0vsHN4hGRrSMYPd3hckSW
tJVewHuOmXgWQxNWV7Oiszu1d9xAcqyj65s1PrEIIaHnxEM3eTK+teecLEy8QymZjjDTrCHg4x36
2AczdlQAIiq5TSAucGja5VP8g1zTnfL/RAxEZvLS471GABptArolXY2hMVHdVEYcTduZlu8aHARc
phXveOB5/l3bPqpMVf2aFalv4ab733Aw6cPuQkbtwpMFifp9Y3s/0HGBfADomK4OeDTDJfuvCp8g
a907E48SjOJBGkh6c6B3ace2XH+CyB7+WBsoK6hsrV5twAXSe7frgP4lN/4Cm2isQl3D7vXM3PBQ
ddI2aZzmewTfbgZptt4KCUhZh+t7FGB6ZKppQ++Rx0zsGN1s71MtjJnhXvJyPs9UyL1n7KQPTEX/
07kwIwdMjxC/hpbZmVq0mVccpMy7FYlTuiwFD+TEnhmxGDTVTJ267fcfrySVBHioA7vugeXaX3yL
SqGQdCWnsz5LyCxWvcfI7zjiXJLwefechLp0LWEBIH5+0fJPB1lfiy1DUutGDJTh9WZHeXfVVFsf
rSQ3y0VaTqBESMjYsJnFFYQJ9tZJScBluOYacW6gqPGC6EU+bNYC1wpngwVayaQQMIIGhTCCBG2g
AwIBAgIMD+aKIot+px9krlZuMA0GCSqGSIb3DQEBCwUAMFIxCzAJBgNVBAYTAkJFMRkwFwYDVQQK
ExBHbG9iYWxTaWduIG52LXNhMSgwJgYDVQQDEx9HbG9iYWxTaWduIEdDQyBSNiBTTUlNRSBDQSAy
MDIzMB4XDTI0MTEyODA2NDkyM1oXDTI2MTEyOTA2NDkyM1owgcMxCzAJBgNVBAYTAlVTMRMwEQYD
VQQIEwpDYWxpZm9ybmlhMREwDwYDVQQHEwhTYW4gSm9zZTEZMBcGA1UEYRMQTlRSVVMrREUtNjYx
MDExNzEWMBQGA1UEChMNQlJPQURDT00gSU5DLjEiMCAGA1UEAxMZS2VlcnRoYW5hIEthbHlhbmFz
dW5kYXJhbTE1MDMGCSqGSIb3DQEJARYma2VlcnRoYW5hLmthbHlhbmFzdW5kYXJhbUBicm9hZGNv
bS5jb20wggEiMA0GCSqGSIb3DQEBAQUAA4IBDwAwggEKAoIBAQCzJUx8cxWWLKOtWyrWjmxtNemY
IAZzJtBCZUu44YcV0VWRTEyy7ETgVKv+gsS31DMOAW6riOQk4Kq1NwaqGpWcNeN4lDbjYNgdsVd+
o9k4EYujmMl0cgM7K7hzNddW+Ay96MU9XKfPz2sgaaEg+yf7Lc4qEJAHoeB0ZjdbljIIRWD7Y/NA
zvboOGCqVTtK/MDNUbO3DM22mnISOsFdyh2D45TWDZTwu4xaGvcSWxLWmvKT/F8eOAs9WQstDJfq
Tmu6blTu87+GvJDl7ve1uoTZ2v8iJJgVmw4FHt60UKs2YygdJ0VyVdlGaqP2t1tRmfUlu7CGVl1p
CsZtHLW+HDLdAgMBAAGjggHnMIIB4zAOBgNVHQ8BAf8EBAMCBaAwgZMGCCsGAQUFBwEBBIGGMIGD
MEYGCCsGAQUFBzAChjpodHRwOi8vc2VjdXJlLmdsb2JhbHNpZ24uY29tL2NhY2VydC9nc2djY3I2
c21pbWVjYTIwMjMuY3J0MDkGCCsGAQUFBzABhi1odHRwOi8vb2NzcC5nbG9iYWxzaWduLmNvbS9n
c2djY3I2c21pbWVjYTIwMjMwZQYDVR0gBF4wXDAJBgdngQwBBQMBMAsGCSsGAQQBoDIBKDBCBgor
BgEEAaAyCgMCMDQwMgYIKwYBBQUHAgEWJmh0dHBzOi8vd3d3Lmdsb2JhbHNpZ24uY29tL3JlcG9z
aXRvcnkvMAkGA1UdEwQCMAAwQQYDVR0fBDowODA2oDSgMoYwaHR0cDovL2NybC5nbG9iYWxzaWdu
LmNvbS9nc2djY3I2c21pbWVjYTIwMjMuY3JsMDEGA1UdEQQqMCiBJmtlZXJ0aGFuYS5rYWx5YW5h
c3VuZGFyYW1AYnJvYWRjb20uY29tMBMGA1UdJQQMMAoGCCsGAQUFBwMEMB8GA1UdIwQYMBaAFAAp
Np5ceroPry1QLdugI4UYsKCSMB0GA1UdDgQWBBQHh8+7satHOJPcYL7AeQdvH3LpMDANBgkqhkiG
9w0BAQsFAAOCAgEAYWBk58l2FyT07DXkrrA2hlcTBcEZihWQx8/9g29moMSrBsNjKgfWEAXXBONl
VItnKxTO0LLFBDk0aORtQ77l8a5shNEChWVYr6HaQ4+yEzwgzGmYro7sX9H0WNhPYqGxkaOhvirw
pVpXqJuPEzKRu/cGLsd/0yta4ifC8tbv2NS+/0xF92mVwwFk/drV6gzbXet3UR0Oc4E8X6cuqker
//F6sqQvY8JqD4mfN+FYlRsJMJbaotK+vEh80P3H+DiIl5yMKVsV+IDp7lNqqEr8vp6x1Sd5+kqm
iw/P5dRLJ1fqzim8rqtJ/7qy6A7f9XW26mrfXgopzpH+PpyOWTNn+1WHE3Qsf56FygZkoyRkyNeg
LDRtQlfPVV4VzF2T4Isd4+38Ec+rpHUjh92yzjrf7FL1NWhk9Q7IEFNhX6Ss1VY+qawoyAwq3PCX
N38TFnsqQc+ulwWwKrr/UAidp1h/nDizvfesRK5Iy/qJ+ey9WDm2cuRgn9EKPN4hqc1KVeLWhMS5
2Q76mvXu00vebvmkm8gEOUWX/f/7sJ9OiTxEUFA914opWhBW681OZe8N3qTdG0WpE+Dwuz0tXpzB
QjeGoKexgsMfSRTmaxQT/YnlZiJPM3qfsvSl3wUoJ+GrMGtrszD3Ehg1jbcHkUM/n2fmYA4m1ObI
fGQEpn8e5I0CKl4xggJXMIICUwIBATBiMFIxCzAJBgNVBAYTAkJFMRkwFwYDVQQKExBHbG9iYWxT
aWduIG52LXNhMSgwJgYDVQQDEx9HbG9iYWxTaWduIEdDQyBSNiBTTUlNRSBDQSAyMDIzAgwP5ooi
i36nH2SuVm4wDQYJYIZIAWUDBAIBBQCggccwLwYJKoZIhvcNAQkEMSIEILoWo6leGIbbV8RbRxDS
wBmxNq3iVyqCm2LlUWsL4UO4MBgGCSqGSIb3DQEJAzELBgkqhkiG9w0BBwEwHAYJKoZIhvcNAQkF
MQ8XDTI2MDQwMjA4MDQwN1owXAYJKoZIhvcNAQkPMU8wTTALBglghkgBZQMEASowCwYJYIZIAWUD
BAEWMAsGCWCGSAFlAwQBAjAKBggqhkiG9w0DBzALBgkqhkiG9w0BAQcwCwYJYIZIAWUDBAIBMA0G
CSqGSIb3DQEBAQUABIIBAHujt4b99dmfig5wAYOhUJ9QJvjVNhSdGL08Mhd+LWwYTqwrrDVYgqqX
7cYumleybjM+mciAgskWka8oqCA3V3gJ1rj7Lw4k+J4r30/Lz69pqDxDRa2CJjsHkeUrqjNDohK7
hOsLHjzejfx+qfyunpnoGCzR6eWKhSejNp4UZ2IzG/VE+3ROR3JGR20T777dLmoG5GdPON7ANcdi
pJZ0O7Pipaw/YLobgmwd8WG8YCh32RBUKuT4RxYthl7MhgX3gEOoNPXkIkChsDuWLU+N4NDWYlUr
yJEme+lSxAxDTxWvU+p1+vDxy0aaGTWbefHEhoDT9/t7Xr+DkJfF+dv01LQ=
--0000000000000ca1b8064e75a55d--

