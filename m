Return-Path: <stable+bounces-224548-lists+stable=lfdr.de@vger.kernel.org>
Delivered-To: lists+stable@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id MBB5AHVpsGmNjAIAu9opvQ
	(envelope-from <stable+bounces-224548-lists+stable=lfdr.de@vger.kernel.org>)
	for <lists+stable@lfdr.de>; Tue, 10 Mar 2026 19:56:53 +0100
X-Original-To: lists+stable@lfdr.de
Received: from tor.lore.kernel.org (tor.lore.kernel.org [172.105.105.114])
	by mail.lfdr.de (Postfix) with ESMTPS id 7172A256BD5
	for <lists+stable@lfdr.de>; Tue, 10 Mar 2026 19:56:52 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by tor.lore.kernel.org (Postfix) with ESMTP id 7265D30A5DE2
	for <lists+stable@lfdr.de>; Tue, 10 Mar 2026 18:55:59 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id B9FEA3BD63E;
	Tue, 10 Mar 2026 18:55:56 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linuxtx.org header.i=@linuxtx.org header.b="MUuEU+ET"
X-Original-To: stable@vger.kernel.org
Received: from mail-dl1-f52.google.com (mail-dl1-f52.google.com [74.125.82.52])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4714C3BD65D
	for <stable@vger.kernel.org>; Tue, 10 Mar 2026 18:55:53 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=74.125.82.52
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1773168956; cv=none; b=nbvW/9Mc5Iw1KPzkMFm6pCi8Xg9x6eidl5yAkrUUKFDEcBvbcx08cUC6lKCB0i5yOXltU41qm4D73GbPECQysndh3WpaDn0hCCPaX7TT6COqojmpLRpoyOOCNlaPsNnXCEWMgeUGjDGFEBZOy8j2TRsSC2lNMgnvNcmwDqGLLQY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1773168956; c=relaxed/simple;
	bh=JIV7GzVbpLnLuaEK5/zFdC2TJRtVHYh8P8kjKCCHdGY=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=Kym1NnTYrtirPSB+oK5IOjzcPATUG+SUN+g1mlGYeV5k2oxw+Pc8Nrr7R5BNsrTbi/aF25GSBMi/CyNxMaDcLM3uoQfpmh84DyvcF0xK/6B8MUOK+d8pcMdUppH2XTn/0yX170IzpbFoQd2wQcMnv0yU7eLD6weUa7sJPOBC7F4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=fail (p=none dis=none) header.from=fedoraproject.org; spf=pass smtp.mailfrom=linuxtx.org; dkim=pass (1024-bit key) header.d=linuxtx.org header.i=@linuxtx.org header.b=MUuEU+ET; arc=none smtp.client-ip=74.125.82.52
Authentication-Results: smtp.subspace.kernel.org; dmarc=fail (p=none dis=none) header.from=fedoraproject.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linuxtx.org
Received: by mail-dl1-f52.google.com with SMTP id a92af1059eb24-127380532eeso873723c88.1
        for <stable@vger.kernel.org>; Tue, 10 Mar 2026 11:55:53 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linuxtx.org; s=google; t=1773168952; x=1773773752; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:sender:from:to:cc:subject:date:message-id
         :reply-to;
        bh=UQ72vUindK+cFfJ95rdlTtKUowMa4key6184d5W9Acc=;
        b=MUuEU+ETZdEH5d6oun1WDoVGKfFoByl1vxIAzs9M2iz/JsJtVPvX7mIYn17S0RBOeD
         KqF+FJG2bVk2oGTf5i/izFhOSOBWWIV0tPoH+SfGXzz7fQTe/7irBbntIceilknNYV0V
         3oG5vpPVhz5FTn/7GpNwFOreYLukcRL8FpDb0=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1773168952; x=1773773752;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:sender:x-gm-gg:x-gm-message-state:from:to
         :cc:subject:date:message-id:reply-to;
        bh=UQ72vUindK+cFfJ95rdlTtKUowMa4key6184d5W9Acc=;
        b=fXntG7l9kGDlMylu9qklFjnDp/t43vAa6KI6qJcK5VIYBFgAJW3ruEV1QYbc71f1b8
         YTj9GLag2igZVwFzxHRGsJMuUkaIP+E6nq1Az/OefYap5DNzxYN7rhNW/WxWiPx9LovF
         CRSJ0UXzIP6D1AvQW56OvpNobgmtWzhmr28qd0eHR8SM7YeWdmAhj0A43Knr2UlQoOrB
         QJyK5OG7EA5Jh0HKYaFBVM+eKMx6pLhbIbOTF82doqVkRW3lQ87gZAbURr2Rw0eacs8o
         J22uNrnmnseptjR90M7GeO5pcLNHZf1YBOXLBGnw9G6CT5784/wf/C4q1aWXmaZfgBz3
         j5rA==
X-Forwarded-Encrypted: i=1; AJvYcCVamkw2qo+kx1AVuXabLjgYYwqL2V0NdOSh6yssGEXmCPif2c31PC3YGlmb2BDDJm10djusBHY=@vger.kernel.org
X-Gm-Message-State: AOJu0YzQK61GPOzTbudnfvsy3TrV4aCGQR+8CgXyCSv9H4GI88WXDgXx
	5C1iQh8kRqUxm08lsU8+co/YpEgYNI4iI46vdiI+a6epx7oIZxe81kSA2wn+NhMb1w==
X-Gm-Gg: ATEYQzwPPzI/UFFrYU3CqN6RF8Br7pcy9QE2yI/+wBNIGOzB3BdhBKVanr3FQUAb9EP
	+c8iWEe4s/Z7GROb5fkQRZ6xy6+Hr4NnR/CRKY0rNVCa+ROLTAv0S3Egch0RilXcmLFP50zIjiA
	cLBcsutTvbd5jrF7PRM0zhHG1AjiXslU9gw+iMHC23W4sn1YTEMj+ckX/874bwdFy2iKN0+7REH
	bVHV2gcBYdVDBdAMwI3+XHfZclO/161MS/xh/oO8AEZH/xwLCS7tc1PjTw0q6KzujEbGtVAAGQ6
	UyosPfpbr81wjROYTAIs6ymooM2Y+piWGmEN5NBU0dOvI7sV2KIIwI1Avx3BIMDulLyR5nKTI8D
	tJAvVg5wzEvf3REIzrmiCrEQnAEayK4K5SV0xJHmI1hQ16lXExYNBwCIO2R0lXm2QrVFdcDqTWG
	56Fex7luOpWLObr56YJusiURx+fmSOSmT2fgNCS3oyNpRlurPhOMfIkg==
X-Received: by 2002:a05:7022:518:b0:124:abaa:7ff2 with SMTP id a92af1059eb24-128c2e7ece1mr8340992c88.24.1773168952196;
        Tue, 10 Mar 2026 11:55:52 -0700 (PDT)
Received: from fedora64.linuxtx.org ([216.147.127.21])
        by smtp.gmail.com with ESMTPSA id a92af1059eb24-128d5aa8f5esm11602041c88.6.2026.03.10.11.55.49
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 10 Mar 2026 11:55:51 -0700 (PDT)
Sender: Justin Forbes <jmforbes@linuxtx.org>
Date: Tue, 10 Mar 2026 12:55:48 -0600
From: Justin Forbes <jforbes@fedoraproject.org>
To: Sasha Levin <sashal@kernel.org>
Cc: linux-kernel@vger.kernel.org, stable@vger.kernel.org,
	gregkh@linuxfoundation.org, patches@lists.linux.dev,
	torvalds@linux-foundation.org, akpm@linux-foundation.org,
	linux@roeck-us.net, shuah@kernel.org, patches@kernelci.org,
	lkft-triage@lists.linaro.org, pavel@nabladev.com,
	jonathanh@nvidia.com, f.fainelli@gmail.com,
	sudipm.mukherjee@gmail.com, rwarsow@gmx.de, conor@kernel.org,
	hargar@microsoft.com, broonie@kernel.org, achill@achill.org,
	sr@sladewatkins.com
Subject: Re: [PATCH 6.19 000/311] 6.19.7-rc1 review
Message-ID: <abBpNGge_DDUtNJu@fedora64.linuxtx.org>
References: <cover.1773140654.git.sashal@kernel.org>
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <cover.1773140654.git.sashal@kernel.org>
X-Rspamd-Queue-Id: 7172A256BD5
X-Rspamd-Server: lfdr
X-Spamd-Result: default: False [-0.06 / 15.00];
	SUSPICIOUS_RECIPS(1.50)[];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	R_DKIM_ALLOW(-0.20)[linuxtx.org:s=google];
	R_SPF_ALLOW(-0.20)[+ip4:172.105.105.114:c];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	DMARC_POLICY_SOFTFAIL(0.10)[fedoraproject.org : SPF not aligned (relaxed), DKIM not aligned (relaxed),none];
	HAS_LIST_UNSUB(-0.01)[];
	TAGGED_FROM(0.00)[bounces-224548-lists,stable=lfdr.de];
	RCVD_TLS_LAST(0.00)[];
	FROM_HAS_DN(0.00)[];
	FORGED_SENDER_MAILLIST(0.00)[];
	FREEMAIL_CC(0.00)[vger.kernel.org,linuxfoundation.org,lists.linux.dev,linux-foundation.org,roeck-us.net,kernel.org,kernelci.org,lists.linaro.org,nabladev.com,nvidia.com,gmail.com,gmx.de,microsoft.com,achill.org,sladewatkins.com];
	RCPT_COUNT_TWELVE(0.00)[21];
	MIME_TRACE(0.00)[0:+];
	DKIM_TRACE(0.00)[linuxtx.org:+];
	MISSING_XM_UA(0.00)[];
	TO_DN_SOME(0.00)[];
	RCVD_COUNT_FIVE(0.00)[5];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[jforbes@fedoraproject.org,stable@vger.kernel.org];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	NEURAL_HAM(-0.00)[-1.000];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	TAGGED_RCPT(0.00)[stable];
	ASN(0.00)[asn:63949, ipnet:172.105.96.0/20, country:SG];
	DBL_BLOCKED_OPENRESOLVER(0.00)[linuxtx.org:dkim,tor.lore.kernel.org:rdns,tor.lore.kernel.org:helo,fedoraproject.org:email,fedora64.linuxtx.org:mid]
X-Rspamd-Action: no action

On Tue, Mar 10, 2026 at 07:05:54AM -0400, Sasha Levin wrote:
> 
> This is the start of the stable review cycle for the 6.19.7 release.
> There are 311 patches in this series, all will be posted as a response
> to this one.  If anyone has any issues with these being applied, please
> let me know.
> 
> Responses should be made by Thu Mar 12 11:04:16 AM UTC 2026.
> Anything received after that time might be too late.
> 
> The whole patch series can be found in one patch at:
>         https://git.kernel.org/pub/scm/linux/kernel/git/stable/linux-stable-rc.git/rawdiff/?id=linux-6.19.y&id2=v6.19.6
> or in the git tree and branch at:
>         git://git.kernel.org/pub/scm/linux/kernel/git/stable/linux-stable-rc.git linux-6.19.y
> and the diffstat can be found below.
> 
> Thanks,
> Sasha

Tested rc1 against the Fedora build system (aarch64, ppc64le, s390x,
x86_64), and boot tested x86_64. No regressions noted.

Tested-by: Justin M. Forbes <jforbes@fedoraproject.org>

