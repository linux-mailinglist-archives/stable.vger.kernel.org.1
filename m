Return-Path: <stable+bounces-214477-lists+stable=lfdr.de@vger.kernel.org>
Delivered-To: lists+stable@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id 6EK1Kc6qhGk14QMAu9opvQ
	(envelope-from <stable+bounces-214477-lists+stable=lfdr.de@vger.kernel.org>)
	for <lists+stable@lfdr.de>; Thu, 05 Feb 2026 15:35:58 +0100
X-Original-To: lists+stable@lfdr.de
Received: from sin.lore.kernel.org (sin.lore.kernel.org [104.64.211.4])
	by mail.lfdr.de (Postfix) with ESMTPS id A32D5F416C
	for <lists+stable@lfdr.de>; Thu, 05 Feb 2026 15:35:57 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sin.lore.kernel.org (Postfix) with ESMTP id 58F60300847E
	for <lists+stable@lfdr.de>; Thu,  5 Feb 2026 14:34:40 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 27FF63F23D7;
	Thu,  5 Feb 2026 14:34:37 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=ciq.com header.i=@ciq.com header.b="poNdSXMx"
X-Original-To: stable@vger.kernel.org
Received: from mail-qv1-f54.google.com (mail-qv1-f54.google.com [209.85.219.54])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B62113EFD0E
	for <stable@vger.kernel.org>; Thu,  5 Feb 2026 14:34:36 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=pass smtp.client-ip=209.85.219.54
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1770302076; cv=pass; b=BS+ZgVXY3C0MEZnfj0iBJn75WfM0yunpnzdu2GFsqf08byusEbAUNLQthUaW76wtW7D1KDMpxx3O2v4Rkl7kmG8n1KqZnt+5rDtY1uaCv4AUIQzKiM+xqBpG97dH3NIYaby6KNiIi+sXO8cpGROVppKe7LhCtpz0Vtsef2Hvxds=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1770302076; c=relaxed/simple;
	bh=reZXgYMQs1E5L/mUDPMQtu+CUcwp1XuOpZjO9yoB8Pc=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=AKQHnVhYBkQ+Hef0FoqAZO+BjJ5OotMtUBBzlhGLKHYPnjLCGaLEG64fw7zi8rVTOquo90wuY9vUqQS2GKuVLnpqmVSBHyAW5JtMjn6tw8BaOxyA+WX1BKc+fPWnPR4aSj3h5KaaG627+C6XKasvvt5ssjb8LDLnZWEh4wiH6uY=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=ciq.com; spf=pass smtp.mailfrom=ciq.com; dkim=pass (2048-bit key) header.d=ciq.com header.i=@ciq.com header.b=poNdSXMx; arc=pass smtp.client-ip=209.85.219.54
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=ciq.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=ciq.com
Received: by mail-qv1-f54.google.com with SMTP id 6a1803df08f44-8947e6ffd20so15792936d6.1
        for <stable@vger.kernel.org>; Thu, 05 Feb 2026 06:34:36 -0800 (PST)
ARC-Seal: i=1; a=rsa-sha256; t=1770302076; cv=none;
        d=google.com; s=arc-20240605;
        b=iM9h6LemVvCqVYyZSwBMNdV/WmoiUcgygaE1VLCvskMftPMIcg4iTRRivpdZn6mFEw
         PRwG21wOmIxush7lFHLQLCBIIQvyUGlfMRvD+v2uRAKT7qK7Aw3r66VMvIdZydrJOthM
         GjfzrkJOKOyAI72YGZLSkoQbrYh2r/++4IddlbcgXcXkudH4Mg6b/dQal6gQUCDJqPpJ
         xuCAtJLlAj7Ck+NcS8ien2yzWAcUFQVSvQIleqYeVBf/eUs/4+xPttJlrL67FRsJ+juw
         oFY+Xi4e1nL5DhcD9EAXVGWa322uJppM6RnL6cPfdYmPc/eeoqiZSTnMjuxDD0Xvi7B+
         QpGw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20240605;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:dkim-signature;
        bh=5T8kSYzCJlABHfxuED/EI22H/0YkPSOohQqiX6XhgSo=;
        fh=bN1N9u37F9sfpeWZ2mDRMBHW5qqsdrFlcOzPW13gTq4=;
        b=goe7+uNYO+CcRyxoLmEuzEo3PRcK+Wbwo4YXvIx1l2BeOJuOrDMHC/RmsPWadcCR88
         1rQlI5kiGnH5Mra8DmMPN26A+/gMmpFm1bYlKG9CkNY12jiNUnzI3rNHn0jiNjWUHrbM
         o5rTO0jqdqxUZsERV/lz1AgKCjmC9IBhQZwgPdzM0NiZFJc8+4Mh7EXAbBw4AA/L5MSi
         Cvohr09iAg8rMTMDOO1MqB2xncM3hkVhOwpYgdM+S7udSYWO8oaJTqnHY4782OE8DHbs
         CBp6O2l2cqB9CFOziZPZEq8mE99snVwz79CysYDTXKV3Hedh3d0EYEVO0QH8wUm0+W43
         6mwg==;
        darn=vger.kernel.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=ciq.com; s=s1; t=1770302076; x=1770906876; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=5T8kSYzCJlABHfxuED/EI22H/0YkPSOohQqiX6XhgSo=;
        b=poNdSXMxzvt0On22k0AOw7Sbwlefofi0EYQAgKukemg6AutNgrbo6AOpeNE6bhuNbc
         OTxg/frSuohuCI0fpwYsq6j2Le8b4MjwM6mBgMnFcU769BEPcC7fpBxtAV0cd1GqGeFQ
         8LqtlzJbTTJlCeISHnKBK96i2taz/AbW0dtjDrwbmA+VN9KVLCJnG8aSP7jay4K9yM+U
         hKekiwR5OGAVcwpGTxpfAydkAei3Mm5ojuBCGsTmuy2JlgEZAExqQBdnF1nAdt4hihSs
         vBqAWecpNBmdAIaEC+gUYxjUa2yzhtI1HqVL7qkus1P3uyzas0lspFKzozpXGO4P7Uzs
         2FJA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1770302076; x=1770906876;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=5T8kSYzCJlABHfxuED/EI22H/0YkPSOohQqiX6XhgSo=;
        b=jt8ieJzfKKMI7uSkSi9KfKtDHHuxPAGoSBtbsCrqPvWhB7lzmMm53LxnvryYHvWHOm
         o64EDXDyWl3YOUQpWaqRUjHZq6GjXwaHePSD2CnGabFpQhMhkxT8qN8q9WuKYOvhQkzY
         sdy88000+zyYXkVZDwFzWlrl367K5ILf1u+UzbQp818aNnsV4tTqVvEdxeQ3R5cL/yyi
         iTeOEYvC4D/tnFjNqS92T+lgUfHKVo8StUnm3Dj8ln0Jlb5HXc/qS1v+cDJXZO10lmAL
         QmzJnsIt7nyO3XyzNzW9HAxBcDAPEfDkBvvU/VSkHMPfiW+4XZv/iPVyU/l2YP3LMwXK
         ftNQ==
X-Gm-Message-State: AOJu0YzXcZVXYUCK5SvZPUG9okeZygx/yChi96JmJHcIzsc0wER99z71
	7P9pK5POL3MgJ8IBouIOcH9qViFxuDTK7Eb/4PMYDuqiKDqSsJNkl2RF1olpqbutgUFZ+qVNqui
	ePjFsAnVYDle/9GgjhlTFPxiLS/7/usQ72KjqVc/tOA==
X-Gm-Gg: AZuq6aKUfS3sSoxRBH5Z/wpQjtLDPx+yf+kgzZl06ScZVeYPRhgkytupiNTfhRAaW3r
	OXIb7KeD3StNiHKllrM6Reu93XeR/toedtqMfJj8nyuCpT0mKFGcpEISt4Mgm+R0A3r5s/Lodf4
	+HWZY7oV75/+Y7+Y+QDwg1I7HRm6oV9bIOqtEU6D15izkHCaJDnuA9LFRRZYtbDmekNTrWaTObU
	mKC0PHf180p+1ToJT4qFK12zUH1JkPjaKTWzN9xyf/Z3R46shtlS6vl8rIRDlsMVOY2ULmj
X-Received: by 2002:ad4:5cc4:0:b0:894:6f04:3bb with SMTP id
 6a1803df08f44-895221cc9ecmr104433826d6.57.1770302075594; Thu, 05 Feb 2026
 06:34:35 -0800 (PST)
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20260204143846.906385641@linuxfoundation.org>
In-Reply-To: <20260204143846.906385641@linuxfoundation.org>
From: Brett Mastbergen <bmastbergen@ciq.com>
Date: Thu, 5 Feb 2026 09:34:24 -0500
X-Gm-Features: AZwV_QhvyilFO5rNcQ43Antjxe7oGwhjvv7M5ElotkayOstzeUUcxm7UHt8eCSQ
Message-ID: <CAOBMUvjL1dq+bKWS915+=azSzn01TOHhd1TgLB4Kwqgp_1o5pw@mail.gmail.com>
Subject: Re: [PATCH 6.12 00/87] 6.12.69-rc1 review
To: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
Cc: stable@vger.kernel.org, patches@lists.linux.dev, 
	linux-kernel@vger.kernel.org, torvalds@linux-foundation.org, 
	akpm@linux-foundation.org, linux@roeck-us.net, shuah@kernel.org, 
	patches@kernelci.org, lkft-triage@lists.linaro.org, pavel@denx.de, 
	jonathanh@nvidia.com, f.fainelli@gmail.com, sudipm.mukherjee@gmail.com, 
	rwarsow@gmx.de, conor@kernel.org, hargar@microsoft.com, broonie@kernel.org, 
	achill@achill.org, sr@sladewatkins.com
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
X-Rspamd-Server: lfdr
X-Spamd-Result: default: False [-0.66 / 15.00];
	SUSPICIOUS_RECIPS(1.50)[];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=2];
	DMARC_POLICY_ALLOW(-0.50)[ciq.com,reject];
	R_SPF_ALLOW(-0.20)[+ip4:104.64.211.4:c];
	R_DKIM_ALLOW(-0.20)[ciq.com:s=s1];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	RCVD_TLS_LAST(0.00)[];
	TAGGED_FROM(0.00)[bounces-214477-lists,stable=lfdr.de];
	FROM_HAS_DN(0.00)[];
	RCVD_COUNT_THREE(0.00)[4];
	MIME_TRACE(0.00)[0:+];
	FORGED_SENDER_MAILLIST(0.00)[];
	RCPT_COUNT_TWELVE(0.00)[20];
	FREEMAIL_CC(0.00)[vger.kernel.org,lists.linux.dev,linux-foundation.org,roeck-us.net,kernel.org,kernelci.org,lists.linaro.org,denx.de,nvidia.com,gmail.com,gmx.de,microsoft.com,achill.org,sladewatkins.com];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	TO_DN_SOME(0.00)[];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[bmastbergen@ciq.com,stable@vger.kernel.org];
	DKIM_TRACE(0.00)[ciq.com:+];
	NEURAL_HAM(-0.00)[-1.000];
	ASN(0.00)[asn:63949, ipnet:104.64.192.0/19, country:SG];
	TAGGED_RCPT(0.00)[stable];
	MISSING_XM_UA(0.00)[];
	DBL_BLOCKED_OPENRESOLVER(0.00)[ciq.com:email,ciq.com:dkim,mail.gmail.com:mid,linuxfoundation.org:email]
X-Rspamd-Queue-Id: A32D5F416C
X-Rspamd-Action: no action

On Wed, Feb 4, 2026 at 10:37=E2=80=AFAM Greg Kroah-Hartman
<gregkh@linuxfoundation.org> wrote:
>
> This is the start of the stable review cycle for the 6.12.69 release.
> There are 87 patches in this series, all will be posted as a response
> to this one.  If anyone has any issues with these being applied, please
> let me know.
>
> Responses should be made by Fri, 06 Feb 2026 14:38:23 +0000.
> Anything received after that time might be too late.
>
> The whole patch series can be found in one patch at:
>         https://www.kernel.org/pub/linux/kernel/v6.x/stable-review/patch-=
6.12.69-rc1.gz
> or in the git tree and branch at:
>         git://git.kernel.org/pub/scm/linux/kernel/git/stable/linux-stable=
-rc.git linux-6.12.y
> and the diffstat can be found below.
>
> thanks,
>
> greg k-h
>

Builds successfully.  Boots and works on qemu and Intel Core i7-10810U

Tested-by: Brett Mastbergen <bmastbergen@ciq.com>

Thanks,
Brett

