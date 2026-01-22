Return-Path: <stable+bounces-211251-lists+stable=lfdr.de@vger.kernel.org>
Delivered-To: lists+stable@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id yNxZJE0+cmnpfAAAu9opvQ
	(envelope-from <stable+bounces-211251-lists+stable=lfdr.de@vger.kernel.org>)
	for <lists+stable@lfdr.de>; Thu, 22 Jan 2026 16:12:13 +0100
X-Original-To: lists+stable@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [172.234.253.10])
	by mail.lfdr.de (Postfix) with ESMTPS id E46F26877B
	for <lists+stable@lfdr.de>; Thu, 22 Jan 2026 16:12:12 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id E6551301ECC4
	for <lists+stable@lfdr.de>; Thu, 22 Jan 2026 15:06:54 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id E385E33C191;
	Thu, 22 Jan 2026 15:06:53 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=ciq.com header.i=@ciq.com header.b="GKzrfFsG"
X-Original-To: stable@vger.kernel.org
Received: from mail-qk1-f172.google.com (mail-qk1-f172.google.com [209.85.222.172])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5B00E2DF142
	for <stable@vger.kernel.org>; Thu, 22 Jan 2026 15:06:50 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=pass smtp.client-ip=209.85.222.172
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1769094413; cv=pass; b=H04sp1IA/QjuIIseZ+C0QFwX73UGsKTAZjamMHykijG9kKayMidQcOvGnvIaWTJ7vEBgWppmFJT+WRQAYdLgGtrfIc/7mZQ2ZUr8oK0t4iRVotCx6vzXeFlbAn/U+mFYFYmED7l4qT7/fY9CpXdre2EVPfSAI8DnVR3HlTiPbzI=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1769094413; c=relaxed/simple;
	bh=zChY9g9QiZ2j/L6PoeholoqDqkO3cn0KCtgYtxidmEU=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=dCXdTLlOEqyNcQ3FwW/Z/8HngVORJanMQSNk8z/+dtKhwGraOFoYQIK4sEzjnEt/hciSd2wblflP7/CO6B2OXZ9j5oRaz0F/Vt1jDHKtJgvXiBO/TJnzMDdZTJ/KWKno1bmpKDoaQKAll4dA6vq43NhFCXUT3dXpilV3G9onvUY=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=ciq.com; spf=pass smtp.mailfrom=ciq.com; dkim=pass (2048-bit key) header.d=ciq.com header.i=@ciq.com header.b=GKzrfFsG; arc=pass smtp.client-ip=209.85.222.172
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=ciq.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=ciq.com
Received: by mail-qk1-f172.google.com with SMTP id af79cd13be357-8c531473fdcso131502185a.3
        for <stable@vger.kernel.org>; Thu, 22 Jan 2026 07:06:50 -0800 (PST)
ARC-Seal: i=1; a=rsa-sha256; t=1769094409; cv=none;
        d=google.com; s=arc-20240605;
        b=WG0sibPNDV0BBPqlaHQf6/b2LwtTPrrYTXL5cXsnS17hJV2GkA3Ce4M38QQlEvFU/f
         l0bbnPjb8Y0r9Dq2dE0dEEjBzH3/uLXnczBuHSNh5GmXYjCFvmHVd258XCr/6Zryxa4Z
         Rpg4F5q2oswnwfyJ6URutTP2yg9nl77lBIzkBrEhNlRkQDkPyNQoJ848SHb9YZJO1pcy
         SD1FQ0lc2EWaEaUK3gVsLeY/cA+wMpXyUrJLnxiWqNqAgtidbbuoCquc+GKoZZpeSl/r
         EbDmd8v5gCIg1i3RsXT4hs67h1AUBsEULj2s007Ydl1i+R1Nsk6pH/DrSMRYvidNZ6kk
         PRjA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20240605;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:dkim-signature;
        bh=ygDx271Y0S0OopKEObkAzsR5sQdsbflGYcm3pyskm28=;
        fh=bN1N9u37F9sfpeWZ2mDRMBHW5qqsdrFlcOzPW13gTq4=;
        b=XlvCK4s1ziiEp89+MQ6xCH2WvhHjVwwVhft46Zd+q/iG3W3R76Agj+rVZW8s56qCWk
         8H9WJFFlitC+79/hr1Lg+PSMfpbOQyx5yIs7qtwIrxiUDMb2wH+EEJdbMZrubhMX2z0R
         My49NqDvp5UsiBkLTpk4w7PWa4TRcWqAYDyjTZDxS312NR7SBINGf6mlNajYpNIR7cJR
         rYkKOjugXvdt+pdsjCZwBLwK/0LYNsD7qLbQPFLXtW3KE8ZZm0iP1BU2EfQYVJ2WjiR5
         F64guCg9s+zCokZ0RqPui9d4nkW2DlrPRJZt5QKiT5Em4HzQcn6iODLr2+R9QtqFfDaR
         b9Bg==;
        darn=vger.kernel.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=ciq.com; s=s1; t=1769094409; x=1769699209; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=ygDx271Y0S0OopKEObkAzsR5sQdsbflGYcm3pyskm28=;
        b=GKzrfFsGm2/TkpDHP9ipmv0+3OE8YaBG7Bim495AkEy7TU0duOwlmW/u/50twwvh9b
         D/qC+7/2VSlJPbZI1ksc1HXb7JUZ0hk+Rg9cPiPTCv4Y4GnXZVAzORINPLAj8mDLSzUg
         BwFBXZSMSEqzDlGEFO+CsOBp4Zbj6Nhxyz905mZ/6g7c6GD7VHrrvfH8U3OcKgpHGivM
         2SYcrR6m43c5ojoTFn0vgD9Srirg9LO1iV+yT8CuyremcwyqNdvzXLp0KIPgUE0gEkrl
         jlnYPTeZcCXO0qlia96YJ/1GRXTjRA46VD5qxa0MmvJ+PYHFjZP+qYBE1q4uWGzh57YA
         S8uQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1769094409; x=1769699209;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=ygDx271Y0S0OopKEObkAzsR5sQdsbflGYcm3pyskm28=;
        b=lkzGB2oQQGk9TRozmyJgM0wocx32xMmjU6dVdVRNpFGubv+97byQ8JoVJZsPTQ+/fp
         xQefz2WQ7zLU+IIYItJqDri4GAkG/UeutwoQrA10IT2buMDnnFUMxIBNzmGreqgtko6T
         dvRKGhYMGzWdybfhmjuAjTzqnS0EdbRxb11KU67YLprK8rgcXosgwVW1FgfI6CkhnYo5
         T6FD43Rjw+0WCUnmK6UDKEIRWGvrZvDFPSCw/HTOuBgsDVqOTlVYQ1jxxwYzJg8jkPDW
         SmknqmSFgI1p5NZYIS/2SEqmpqxtn9ZS9Rx+kNiLMVWhs+AfaUu5ra53nXc+ZDMy9CVC
         7GbQ==
X-Gm-Message-State: AOJu0YzY7+XZgHfHclr+Stk5wyoWuYnCk9wHaztomrr+xxaE503YG5aa
	RVEkMVzqOngVBN69szbf2I628NcwMvhCqwALhOq5WuqQ13d4vYwPslMbBpYCkB1+OzuM23OvvSA
	uwbk4Jn99S+mf5GvRxjQF5LG4BUFw2SzNEpmkGocjKA==
X-Gm-Gg: AZuq6aK6qmXMHxXdd6i1q7Ky98XUq8ucw330lc8BbSP6o/AypzyNEzWCNmiMHSQzFu5
	oVSJs/51Vd3DV5HkXCBdAodqfNNO0zpAXPq/J9mKS8/z0ryzEoEKbaBNaZIxohtdDtwJq64roun
	85RLAFlaU2bbrZoE5HrOL+BTg34Q34k7BPpzVozvhc464xL+r5OmEP53dE2tYldMEn/gfmWCCkM
	6K8Bm+HvfzPn0ZTGTQqiy243u1nBBrubvoH+7OlH7dFrLl171ZFmS6yO5CN/9/m3gdVFeLt
X-Received: by 2002:a05:620a:1794:b0:8b8:dd7f:f032 with SMTP id
 af79cd13be357-8c6a6979c1fmr2837675985a.78.1769094409009; Thu, 22 Jan 2026
 07:06:49 -0800 (PST)
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20260121181411.452263583@linuxfoundation.org>
In-Reply-To: <20260121181411.452263583@linuxfoundation.org>
From: Brett Mastbergen <bmastbergen@ciq.com>
Date: Thu, 22 Jan 2026 10:06:37 -0500
X-Gm-Features: AZwV_QhMiQHqhJbB72TePco8pls6ayYvyPgeqKVZdDBP2ASsrAS5S8VEPOBSX9E
Message-ID: <CAOBMUvjtyWdRSR3dON18mN74uO2kLdhBB9b2V=Zm2qpJ-GQOJA@mail.gmail.com>
Subject: Re: [PATCH 6.12 000/139] 6.12.67-rc1 review
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
	R_DKIM_ALLOW(-0.20)[ciq.com:s=s1];
	R_SPF_ALLOW(-0.20)[+ip4:172.234.253.10:c];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	RCVD_TLS_LAST(0.00)[];
	TAGGED_FROM(0.00)[bounces-211251-lists,stable=lfdr.de];
	RCPT_COUNT_TWELVE(0.00)[20];
	RCVD_COUNT_THREE(0.00)[4];
	FORGED_SENDER_MAILLIST(0.00)[];
	MIME_TRACE(0.00)[0:+];
	FROM_HAS_DN(0.00)[];
	DKIM_TRACE(0.00)[ciq.com:+];
	TO_DN_SOME(0.00)[];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[bmastbergen@ciq.com,stable@vger.kernel.org];
	FREEMAIL_CC(0.00)[vger.kernel.org,lists.linux.dev,linux-foundation.org,roeck-us.net,kernel.org,kernelci.org,lists.linaro.org,denx.de,nvidia.com,gmail.com,gmx.de,microsoft.com,achill.org,sladewatkins.com];
	TAGGED_RCPT(0.00)[stable];
	MISSING_XM_UA(0.00)[];
	ASN(0.00)[asn:63949, ipnet:172.234.224.0/19, country:SG];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	DBL_BLOCKED_OPENRESOLVER(0.00)[linuxfoundation.org:email,ciq.com:email,ciq.com:dkim,mail.gmail.com:mid,sea.lore.kernel.org:helo,sea.lore.kernel.org:rdns]
X-Rspamd-Queue-Id: E46F26877B
X-Rspamd-Action: no action

On Wed, Jan 21, 2026 at 2:02=E2=80=AFPM Greg Kroah-Hartman
<gregkh@linuxfoundation.org> wrote:
>
> This is the start of the stable review cycle for the 6.12.67 release.
> There are 139 patches in this series, all will be posted as a response
> to this one.  If anyone has any issues with these being applied, please
> let me know.
>
> Responses should be made by Fri, 23 Jan 2026 18:13:43 +0000.
> Anything received after that time might be too late.
>
> The whole patch series can be found in one patch at:
>         https://www.kernel.org/pub/linux/kernel/v6.x/stable-review/patch-=
6.12.67-rc1.gz
> or in the git tree and branch at:
>         git://git.kernel.org/pub/scm/linux/kernel/git/stable/linux-stable=
-rc.git linux-6.12.y
> and the diffstat can be found below.
>
> thanks,
>
> greg k-h
>

Builds successfully.  Boots and works on qemu and Dell XPS 15 9520 w/
Intel Core i7-12600H

Tested-by: Brett Mastbergen <bmastbergen@ciq.com>

Thanks,
Brett

