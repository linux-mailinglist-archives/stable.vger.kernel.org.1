Return-Path: <stable+bounces-227224-lists+stable=lfdr.de@vger.kernel.org>
Delivered-To: lists+stable@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id yMmiB1Cgu2kLmAIAu9opvQ
	(envelope-from <stable+bounces-227224-lists+stable=lfdr.de@vger.kernel.org>)
	for <lists+stable@lfdr.de>; Thu, 19 Mar 2026 08:05:52 +0100
X-Original-To: lists+stable@lfdr.de
Received: from tor.lore.kernel.org (tor.lore.kernel.org [172.105.105.114])
	by mail.lfdr.de (Postfix) with ESMTPS id C862D2C712C
	for <lists+stable@lfdr.de>; Thu, 19 Mar 2026 08:05:51 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by tor.lore.kernel.org (Postfix) with ESMTP id 40EEE303320D
	for <lists+stable@lfdr.de>; Thu, 19 Mar 2026 07:05:45 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 6417539DBEB;
	Thu, 19 Mar 2026 07:05:38 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=suse.com header.i=@suse.com header.b="Jntvf7Kk"
X-Original-To: stable@vger.kernel.org
Received: from mail-ed1-f46.google.com (mail-ed1-f46.google.com [209.85.208.46])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A325E34CFCA
	for <stable@vger.kernel.org>; Thu, 19 Mar 2026 07:05:36 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.208.46
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1773903938; cv=none; b=FL4xU7jrX3Yn/65NUXRq+Ce1JyqfQ61CGrbGJ2/EyaI9pepcUvSYJiUqFp1XFEGt7nelEYiamTZx3JWiYQ3fbgXfe1D0o5g3HOE1m3sPKde3OwZW3HoP46j0BmriCUEKC3/+QWd7zw94BSYTI9kCQNjvposek1VgDWy3rIWjV00=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1773903938; c=relaxed/simple;
	bh=wByaUL24vrAyIuOx18rXl10HJ+lmVFi8kPhiaZgqoCk=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=mguPG5BfsPgbg414y5pUya9GiThTd4d2cZ5m92LmuG8iYlbOZZipedh9anJK9m/AHtkR5DbWAxeXmQ1tdxBre4fp2B11BQt3pyMq7O/5Hcjsd0HNKmKab6lbrHI5mVpBOt1EOqnSwNEj8B8GEKfRxffD+ntXZ+5mb2RbdFIaVWk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=suse.com; spf=pass smtp.mailfrom=suse.com; dkim=pass (2048-bit key) header.d=suse.com header.i=@suse.com header.b=Jntvf7Kk; arc=none smtp.client-ip=209.85.208.46
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=suse.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=suse.com
Received: by mail-ed1-f46.google.com with SMTP id 4fb4d7f45d1cf-6611d20c026so963944a12.1
        for <stable@vger.kernel.org>; Thu, 19 Mar 2026 00:05:36 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=suse.com; s=google; t=1773903935; x=1774508735; darn=vger.kernel.org;
        h=in-reply-to:autocrypt:from:content-language:references:cc:to
         :subject:user-agent:mime-version:date:message-id:from:to:cc:subject
         :date:message-id:reply-to;
        bh=wByaUL24vrAyIuOx18rXl10HJ+lmVFi8kPhiaZgqoCk=;
        b=Jntvf7KklahnWZ7Pli2IbyXmBFZ1Byi6PfTXpoXWl0+tpnT1wZraHNUudwZdx/7chP
         2nYTmUQ0YR67wLa8EXYL+ovgax/EeZiV5RaEoLz9jPPzSZKGMv0zDVzf+mdETqkxGJLP
         q4cn9i9jsD/P/dnsbtNA8SOetcB8eYQ7GaJvHMJae9H7vEHgrPb4WI80a3FbaRkbP2zn
         OSvl3pAs8GvtK7C8WQsQPLTtq7/qpfgsVt3Dd6bJRFApN+bNbmS2uXdkEE9kmp3Q2zrj
         /ePO81mnMG0TVTC13a0unAFuyaCaItmPGCoI+M3dI0uICUsUa+YecI/bxAHaGygUHw9H
         xPZA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1773903935; x=1774508735;
        h=in-reply-to:autocrypt:from:content-language:references:cc:to
         :subject:user-agent:mime-version:date:message-id:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=wByaUL24vrAyIuOx18rXl10HJ+lmVFi8kPhiaZgqoCk=;
        b=Ue254t4motxwaWyOp0xCyIZb2y0rUmRZjH3i6BhvqzcH4tIVWbrWDAO/5hZkN6dKln
         UAvK/du+XZl4CMeQ6Gsliq17dErfjn8IO7ABkWtqornh+m2fmW8pjWPJ0fu1E/qdhSH9
         WvjDn6kIqhXN/TaxzdeN5GYm50Cg4CwQcqG6XC/U5kwRR28Pyuz9h1af5iIrPFv4wyac
         eupo3Cz31mTaU7Hpuhb1/xVuIAxGrMzvUqo2Vn3Au6SPNUTYlkSNHErzanTVaRpEWs7u
         ezoC9Wa9YNl57mqNIIZcfYcGpLazkPTuavgxJERD0XJf9UlhZXkSjK1ocAjmMYc5DQEa
         Bz7g==
X-Forwarded-Encrypted: i=1; AJvYcCUfGs9Y01r8UHZZDt5NeuWT5qFSpnAKx9VNRyz9pdma1lWtOsJydYXnA5Ggb3jtGr3KmmbXuB0=@vger.kernel.org
X-Gm-Message-State: AOJu0YwZVjGF1/9gyQ7veyx8wQ3VS5P8RcFzrM0Pn04AJq1YkSGE/eB/
	XhFpyjtQFRFa8zCGDLW+4ZSMaQrQ0Lfda7zRHv3pUgQhjZzj2h+FpOgv3xAt0NPZvvo=
X-Gm-Gg: ATEYQzyNMC0W5tEM38pq/KHYlMNupDlsnN4qat6SFc6x/MafGdUSB5aDiZu0L7K0voD
	ChbPYF0yntj6V+OnwrIzd2brDCQDiGbjHDn/0GWzBYfSxcqD+4CClTHqA2XsNkJ/ARGrJUvYhUe
	f/dDNqEILSNPLc9UswysbPnkv/17VdgHfMI8lmhUhZ6ncMNlnwimGfcYhwlVh35mKJVaLXfmjVe
	RAUbmTzmjwLROTqPt/Tx3ne6OuGkdKpXA1mqzGN8owy11KjnXrmAV7dAoVpV9vKwYdJ+fwNd6mE
	vlQ+zCZEAn89vTv62g7pH9Fau81VWhAc4Jehiz/CbjDgNZKkDuB9QeQ8s0yhK9HSR/MOA34CrpW
	fNqGi+QO2eTVPfPYvOZIquk5GecJDv8nSkUwbPe+KAPr2SntJcGPQ26x0LHIbBZ6VlbN/VOq2Ea
	yFN7zfs8urrjC6D6pAHcY0+YkapHBPy0+tCwtKGQZmnHSfVhYYF7MbCFodOAruWnhFNempEMMAB
	C5afgkNNA1HIqOgo6vfor4Mh5VShJfV8wXcsioDNO0GlpvagE2UFw==
X-Received: by 2002:a05:6402:458a:b0:668:58b6:5061 with SMTP id 4fb4d7f45d1cf-66858b651e5mr869453a12.23.1773903934927;
        Thu, 19 Mar 2026 00:05:34 -0700 (PDT)
Received: from ?IPV6:2a00:12d0:af5d:ad01:5d3f:14e6:9bcb:5112? (2a00-12d0-af5d-ad01-5d3f-14e6-9bcb-5112.ip.tng.de. [2a00:12d0:af5d:ad01:5d3f:14e6:9bcb:5112])
        by smtp.gmail.com with ESMTPSA id 4fb4d7f45d1cf-667b14976f1sm3306167a12.31.2026.03.19.00.05.33
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Thu, 19 Mar 2026 00:05:34 -0700 (PDT)
Message-ID: <5f0ca1fc-9eb4-48ae-b578-f490a6ba5ea3@suse.com>
Date: Thu, 19 Mar 2026 08:05:33 +0100
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v9 4/7] x86/acpi: Add acpi_get_cpu_uid() implementation
 and update Xen users
To: Chengwen Feng <fengchengwen@huawei.com>,
 Bjorn Helgaas <bhelgaas@google.com>,
 Catalin Marinas <catalin.marinas@arm.com>, Will Deacon <will@kernel.org>,
 "Rafael J . Wysocki" <rafael@kernel.org>
Cc: Jonathan Corbet <corbet@lwn.net>, Shuah Khan <skhan@linuxfoundation.org>,
 Huacai Chen <chenhuacai@kernel.org>, WANG Xuerui <kernel@xen0n.name>,
 Paul Walmsley <pjw@kernel.org>, Palmer Dabbelt <palmer@dabbelt.com>,
 Albert Ou <aou@eecs.berkeley.edu>, Alexandre Ghiti <alex@ghiti.fr>,
 Thomas Gleixner <tglx@kernel.org>, Ingo Molnar <mingo@redhat.com>,
 Borislav Petkov <bp@alien8.de>, Dave Hansen <dave.hansen@linux.intel.com>,
 x86@kernel.org, "H . Peter Anvin" <hpa@zytor.com>,
 Boris Ostrovsky <boris.ostrovsky@oracle.com>, Len Brown <lenb@kernel.org>,
 Sunil V L <sunilvl@ventanamicro.com>, Mark Rutland <mark.rutland@arm.com>,
 Jonathan Cameron <jonathan.cameron@huawei.com>, Kees Cook <kees@kernel.org>,
 Yanteng Si <si.yanteng@linux.dev>, Sean Christopherson <seanjc@google.com>,
 Kai Huang <kai.huang@intel.com>, Tom Lendacky <thomas.lendacky@amd.com>,
 Thomas Huth <thuth@redhat.com>, Thorsten Blum <thorsten.blum@linux.dev>,
 Kevin Loughlin <kevinloughlin@google.com>, Zheyun Shen
 <szy0127@sjtu.edu.cn>, Peter Zijlstra <peterz@infradead.org>,
 Pawan Gupta <pawan.kumar.gupta@linux.intel.com>, Xin Li <xin@zytor.com>,
 "Ahmed S . Darwish" <darwi@linutronix.de>,
 Sohil Mehta <sohil.mehta@intel.com>,
 Ilkka Koskinen <ilkka@os.amperecomputing.com>,
 Robin Murphy <robin.murphy@arm.com>, James Clark <james.clark@linaro.org>,
 Besar Wicaksono <bwicaksono@nvidia.com>, Ma Ke <make24@iscas.ac.cn>,
 Wei Huang <wei.huang2@amd.com>,
 Andy Gospodarek <andrew.gospodarek@broadcom.com>,
 Somnath Kotur <somnath.kotur@broadcom.com>, punit.agrawal@oss.qualcomm.com,
 guohanjun@huawei.com, suzuki.poulose@arm.com, ryan.roberts@arm.com,
 chenl311@chinatelecom.cn, masahiroy@kernel.org,
 wangyuquan1236@phytium.com.cn, anshuman.khandual@arm.com,
 heinrich.schuchardt@canonical.com, Eric.VanTassell@amd.com,
 wangzhou1@hisilicon.com, wanghuiqiang@huawei.com, liuyonglong@huawei.com,
 linux-pci@vger.kernel.org, linux-doc@vger.kernel.org,
 linux-kernel@vger.kernel.org, linux-arm-kernel@lists.infradead.org,
 loongarch@lists.linux.dev, linux-riscv@lists.infradead.org,
 xen-devel@lists.xenproject.org, linux-acpi@vger.kernel.org,
 linux-perf-users@vger.kernel.org, stable@vger.kernel.org
References: <20260319065735.45954-1-fengchengwen@huawei.com>
 <20260319065735.45954-5-fengchengwen@huawei.com>
Content-Language: en-US
From: =?UTF-8?B?SsO8cmdlbiBHcm/Dnw==?= <jgross@suse.com>
Autocrypt: addr=jgross@suse.com; keydata=
 xsBNBFOMcBYBCACgGjqjoGvbEouQZw/ToiBg9W98AlM2QHV+iNHsEs7kxWhKMjrioyspZKOB
 ycWxw3ie3j9uvg9EOB3aN4xiTv4qbnGiTr3oJhkB1gsb6ToJQZ8uxGq2kaV2KL9650I1SJve
 dYm8Of8Zd621lSmoKOwlNClALZNew72NjJLEzTalU1OdT7/i1TXkH09XSSI8mEQ/ouNcMvIJ
 NwQpd369y9bfIhWUiVXEK7MlRgUG6MvIj6Y3Am/BBLUVbDa4+gmzDC9ezlZkTZG2t14zWPvx
 XP3FAp2pkW0xqG7/377qptDmrk42GlSKN4z76ELnLxussxc7I2hx18NUcbP8+uty4bMxABEB
 AAHNH0p1ZXJnZW4gR3Jvc3MgPGpncm9zc0BzdXNlLmNvbT7CwHkEEwECACMFAlOMcK8CGwMH
 CwkIBwMCAQYVCAIJCgsEFgIDAQIeAQIXgAAKCRCw3p3WKL8TL8eZB/9G0juS/kDY9LhEXseh
 mE9U+iA1VsLhgDqVbsOtZ/S14LRFHczNd/Lqkn7souCSoyWsBs3/wO+OjPvxf7m+Ef+sMtr0
 G5lCWEWa9wa0IXx5HRPW/ScL+e4AVUbL7rurYMfwCzco+7TfjhMEOkC+va5gzi1KrErgNRHH
 kg3PhlnRY0Udyqx++UYkAsN4TQuEhNN32MvN0Np3WlBJOgKcuXpIElmMM5f1BBzJSKBkW0Jc
 Wy3h2Wy912vHKpPV/Xv7ZwVJ27v7KcuZcErtptDevAljxJtE7aJG6WiBzm+v9EswyWxwMCIO
 RoVBYuiocc51872tRGywc03xaQydB+9R7BHPzsBNBFOMcBYBCADLMfoA44MwGOB9YT1V4KCy
 vAfd7E0BTfaAurbG+Olacciz3yd09QOmejFZC6AnoykydyvTFLAWYcSCdISMr88COmmCbJzn
 sHAogjexXiif6ANUUlHpjxlHCCcELmZUzomNDnEOTxZFeWMTFF9Rf2k2F0Tl4E5kmsNGgtSa
 aMO0rNZoOEiD/7UfPP3dfh8JCQ1VtUUsQtT1sxos8Eb/HmriJhnaTZ7Hp3jtgTVkV0ybpgFg
 w6WMaRkrBh17mV0z2ajjmabB7SJxcouSkR0hcpNl4oM74d2/VqoW4BxxxOD1FcNCObCELfIS
 auZx+XT6s+CE7Qi/c44ibBMR7hyjdzWbABEBAAHCwF8EGAECAAkFAlOMcBYCGwwACgkQsN6d
 1ii/Ey9D+Af/WFr3q+bg/8v5tCknCtn92d5lyYTBNt7xgWzDZX8G6/pngzKyWfedArllp0Pn
 fgIXtMNV+3t8Li1Tg843EXkP7+2+CQ98MB8XvvPLYAfW8nNDV85TyVgWlldNcgdv7nn1Sq8g
 HwB2BHdIAkYce3hEoDQXt/mKlgEGsLpzJcnLKimtPXQQy9TxUaLBe9PInPd+Ohix0XOlY+Uk
 QFEx50Ki3rSDl2Zt2tnkNYKUCvTJq7jvOlaPd6d/W0tZqpyy7KVay+K4aMobDsodB3dvEAs6
 ScCnh03dDAFgIq5nsB11j3KPKdVoPlfucX2c7kGNH+LUMbzqV6beIENfNexkOfxHfw==
In-Reply-To: <20260319065735.45954-5-fengchengwen@huawei.com>
Content-Type: multipart/signed; micalg=pgp-sha256;
 protocol="application/pgp-signature";
 boundary="------------3tp0T0MlZQxaVhr4dI0c0IO4"
X-Spamd-Result: default: False [-2.47 / 15.00];
	SIGNED_PGP(-2.00)[];
	MIME_BASE64_TEXT_BOGUS(1.00)[];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	R_MIXED_CHARSET(0.59)[subject];
	DMARC_POLICY_ALLOW(-0.50)[suse.com,quarantine];
	R_DKIM_ALLOW(-0.20)[suse.com:s=google];
	MIME_GOOD(-0.20)[multipart/signed,multipart/mixed,text/plain];
	R_SPF_ALLOW(-0.20)[+ip4:172.105.105.114:c];
	MAILLIST(-0.15)[generic];
	MIME_BASE64_TEXT(0.10)[];
	MIME_UNKNOWN(0.10)[application/pgp-keys];
	HAS_LIST_UNSUB(-0.01)[];
	TAGGED_FROM(0.00)[bounces-227224-lists,stable=lfdr.de];
	FROM_HAS_DN(0.00)[];
	DKIM_TRACE(0.00)[suse.com:+];
	RCVD_TLS_LAST(0.00)[];
	MIME_TRACE(0.00)[0:+,1:+,2:+,3:+,4:~,5:~];
	FORGED_SENDER_MAILLIST(0.00)[];
	HAS_ATTACHMENT(0.00)[];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	ASN(0.00)[asn:63949, ipnet:172.105.96.0/20, country:SG];
	RCPT_COUNT_GT_50(0.00)[69];
	RCVD_COUNT_FIVE(0.00)[5];
	FROM_NEQ_ENVFROM(0.00)[jgross@suse.com,stable@vger.kernel.org];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	PRECEDENCE_BULK(0.00)[];
	NEURAL_HAM(-0.00)[-0.999];
	MID_RHS_MATCH_FROM(0.00)[];
	TO_DN_SOME(0.00)[];
	TAGGED_RCPT(0.00)[stable];
	DBL_BLOCKED_OPENRESOLVER(0.00)[suse.com:dkim,suse.com:email,suse.com:mid,tor.lore.kernel.org:helo,tor.lore.kernel.org:rdns,huawei.com:email]
X-Rspamd-Queue-Id: C862D2C712C
X-Rspamd-Action: no action
X-Rspamd-Server: lfdr

This is an OpenPGP/MIME signed message (RFC 4880 and 3156)
--------------3tp0T0MlZQxaVhr4dI0c0IO4
Content-Type: multipart/mixed; boundary="------------T7ItBqu2YKFGEfwY3NGBxjdV";
 protected-headers="v1"
From: =?UTF-8?B?SsO8cmdlbiBHcm/Dnw==?= <jgross@suse.com>
To: Chengwen Feng <fengchengwen@huawei.com>,
 Bjorn Helgaas <bhelgaas@google.com>,
 Catalin Marinas <catalin.marinas@arm.com>, Will Deacon <will@kernel.org>,
 "Rafael J . Wysocki" <rafael@kernel.org>
Cc: Jonathan Corbet <corbet@lwn.net>, Shuah Khan <skhan@linuxfoundation.org>,
 Huacai Chen <chenhuacai@kernel.org>, WANG Xuerui <kernel@xen0n.name>,
 Paul Walmsley <pjw@kernel.org>, Palmer Dabbelt <palmer@dabbelt.com>,
 Albert Ou <aou@eecs.berkeley.edu>, Alexandre Ghiti <alex@ghiti.fr>,
 Thomas Gleixner <tglx@kernel.org>, Ingo Molnar <mingo@redhat.com>,
 Borislav Petkov <bp@alien8.de>, Dave Hansen <dave.hansen@linux.intel.com>,
 x86@kernel.org, "H . Peter Anvin" <hpa@zytor.com>,
 Boris Ostrovsky <boris.ostrovsky@oracle.com>, Len Brown <lenb@kernel.org>,
 Sunil V L <sunilvl@ventanamicro.com>, Mark Rutland <mark.rutland@arm.com>,
 Jonathan Cameron <jonathan.cameron@huawei.com>, Kees Cook <kees@kernel.org>,
 Yanteng Si <si.yanteng@linux.dev>, Sean Christopherson <seanjc@google.com>,
 Kai Huang <kai.huang@intel.com>, Tom Lendacky <thomas.lendacky@amd.com>,
 Thomas Huth <thuth@redhat.com>, Thorsten Blum <thorsten.blum@linux.dev>,
 Kevin Loughlin <kevinloughlin@google.com>, Zheyun Shen
 <szy0127@sjtu.edu.cn>, Peter Zijlstra <peterz@infradead.org>,
 Pawan Gupta <pawan.kumar.gupta@linux.intel.com>, Xin Li <xin@zytor.com>,
 "Ahmed S . Darwish" <darwi@linutronix.de>,
 Sohil Mehta <sohil.mehta@intel.com>,
 Ilkka Koskinen <ilkka@os.amperecomputing.com>,
 Robin Murphy <robin.murphy@arm.com>, James Clark <james.clark@linaro.org>,
 Besar Wicaksono <bwicaksono@nvidia.com>, Ma Ke <make24@iscas.ac.cn>,
 Wei Huang <wei.huang2@amd.com>,
 Andy Gospodarek <andrew.gospodarek@broadcom.com>,
 Somnath Kotur <somnath.kotur@broadcom.com>, punit.agrawal@oss.qualcomm.com,
 guohanjun@huawei.com, suzuki.poulose@arm.com, ryan.roberts@arm.com,
 chenl311@chinatelecom.cn, masahiroy@kernel.org,
 wangyuquan1236@phytium.com.cn, anshuman.khandual@arm.com,
 heinrich.schuchardt@canonical.com, Eric.VanTassell@amd.com,
 wangzhou1@hisilicon.com, wanghuiqiang@huawei.com, liuyonglong@huawei.com,
 linux-pci@vger.kernel.org, linux-doc@vger.kernel.org,
 linux-kernel@vger.kernel.org, linux-arm-kernel@lists.infradead.org,
 loongarch@lists.linux.dev, linux-riscv@lists.infradead.org,
 xen-devel@lists.xenproject.org, linux-acpi@vger.kernel.org,
 linux-perf-users@vger.kernel.org, stable@vger.kernel.org
Message-ID: <5f0ca1fc-9eb4-48ae-b578-f490a6ba5ea3@suse.com>
Subject: Re: [PATCH v9 4/7] x86/acpi: Add acpi_get_cpu_uid() implementation
 and update Xen users
References: <20260319065735.45954-1-fengchengwen@huawei.com>
 <20260319065735.45954-5-fengchengwen@huawei.com>
In-Reply-To: <20260319065735.45954-5-fengchengwen@huawei.com>

--------------T7ItBqu2YKFGEfwY3NGBxjdV
Content-Type: multipart/mixed; boundary="------------dgRJU17tRiil2XqvArK0zE1P"

--------------dgRJU17tRiil2XqvArK0zE1P
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: base64

T24gMTkuMDMuMjYgMDc6NTcsIENoZW5nd2VuIEZlbmcgd3JvdGU6DQo+IEFkZCBhcmNoLXNw
ZWNpZmljIGFjcGlfZ2V0X2NwdV91aWQoKSBmb3IgeDg2Og0KPiAtIERlY2xhcmUgYWNwaV9n
ZXRfY3B1X3VpZCgpIGluIGFyY2gveDg2L2luY2x1ZGUvYXNtL2FjcGkuaA0KPiAtIEltcGxl
bWVudCBhY3BpX2dldF9jcHVfdWlkKCkgd2l0aCBpbnB1dCBwYXJhbWV0ZXIgdmFsaWRhdGlv
bg0KPiAtIFJlcGxhY2UgY3B1X2FjcGlfaWQoKSB3aXRoIGFjcGlfZ2V0X2NwdV91aWQoKSBp
biBYZW4tcmVsYXRlZCBjb2RlDQo+IC0gUmVtb3ZlIHRoZSBub3ctdW51c2VkIGNwdV9hY3Bp
X2lkKCkgZnVuY3Rpb24NCj4gDQo+IEV4dGVuZCB0aGUgdW5pZmllZCBBQ1BJIENQVSBVSUQg
aW50ZXJmYWNlIHRvIHg4NiwgZW5zdXJpbmcgY29uc2lzdGVudA0KPiBlcnJvciBoYW5kbGlu
ZyBhbmQgaW5wdXQgdmFsaWRhdGlvbiBhY3Jvc3MgYWxsIEFDUEktZW5hYmxlZA0KPiBhcmNo
aXRlY3R1cmVzLg0KPiANCj4gQ2M6IHN0YWJsZUB2Z2VyLmtlcm5lbC5vcmcNCj4gU2lnbmVk
LW9mZi1ieTogQ2hlbmd3ZW4gRmVuZyA8ZmVuZ2NoZW5nd2VuQGh1YXdlaS5jb20+DQo+IFJl
dmlld2VkLWJ5OiBKb25hdGhhbiBDYW1lcm9uIDxqb25hdGhhbi5jYW1lcm9uQGh1YXdlaS5j
b20+DQoNClJldmlld2VkLWJ5OiBKdWVyZ2VuIEdyb3NzIDxqZ3Jvc3NAc3VzZS5jb20+DQoN
Cg0KSnVlcmdlbg0K
--------------dgRJU17tRiil2XqvArK0zE1P
Content-Type: application/pgp-keys; name="OpenPGP_0xB0DE9DD628BF132F.asc"
Content-Disposition: attachment; filename="OpenPGP_0xB0DE9DD628BF132F.asc"
Content-Description: OpenPGP public key
Content-Transfer-Encoding: quoted-printable

-----BEGIN PGP PUBLIC KEY BLOCK-----

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
kt+z4drzFUyEjLM1vVvIMjkUoJs=3D
=3DeeAB
-----END PGP PUBLIC KEY BLOCK-----

--------------dgRJU17tRiil2XqvArK0zE1P--

--------------T7ItBqu2YKFGEfwY3NGBxjdV--

--------------3tp0T0MlZQxaVhr4dI0c0IO4
Content-Type: application/pgp-signature; name="OpenPGP_signature.asc"
Content-Description: OpenPGP digital signature
Content-Disposition: attachment; filename="OpenPGP_signature.asc"

-----BEGIN PGP SIGNATURE-----

wsB5BAABCAAjFiEEhRJncuj2BJSl0Jf3sN6d1ii/Ey8FAmm7oD0FAwAAAAAACgkQsN6d1ii/Ey+T
4Af7BgRCEqltwxse9iwcB9WhOIH6KFt1MYOFZq112r1cJg+TH/WEse7TN58VY5qa+q1hJREPnezC
LCVT3XE6GrfGVi/BneCT3fapyoRpJo8WUFwvtqIj+QHgdvgl1ic3A6m/3x9PkqZwsbbueYZD9m57
EZQ6a1JXiStwakpyRJTmIi5kL4NFQJWMIgznjeOmWCYpg9vhkpfWZ/x7Tr+tb0OdX+DuqRw+ken9
0FrgxNuxF96ZiXq2q5PB2ntXKoNpSS2n+NIqcn2dsIAb8ICVS1sZHNu5TtbcKPMCz02KbrLaCYa/
WkP0G6aIrA3XQwzQDZddXKuFcNeZqR9TXz4FC71G4Q==
=cF9V
-----END PGP SIGNATURE-----

--------------3tp0T0MlZQxaVhr4dI0c0IO4--

