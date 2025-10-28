Return-Path: <stable+bounces-191380-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id B6348C12B67
	for <lists+stable@lfdr.de>; Tue, 28 Oct 2025 04:03:55 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 3B87B587789
	for <lists+stable@lfdr.de>; Tue, 28 Oct 2025 03:02:48 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 15FBD25C6E2;
	Tue, 28 Oct 2025 03:02:32 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=googlemail.com header.i=@googlemail.com header.b="nbUz0bCs"
X-Original-To: stable@vger.kernel.org
Received: from mail-ej1-f46.google.com (mail-ej1-f46.google.com [209.85.218.46])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 39E78238D54
	for <stable@vger.kernel.org>; Tue, 28 Oct 2025 03:02:30 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.218.46
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1761620551; cv=none; b=TQByO2Y3FkcatdNjYUblLnvqaOORxo0bFzzFtESDBA0lr0QAPyS0dm0o4yqbGuXfGKVXiAMCrkN2uXtaBg7I+oL4mun0PKdkM35sD2gkfrWd0xd9PfgiszKo22rJusAbMw3NUcboHGTW5QKSSxGmgcDCbPf5g08CRJtVZkjaw44=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1761620551; c=relaxed/simple;
	bh=Cpfl+PBLgm9fkdwrdc+sEthpeoG4zd9OLtEpq+UJjVo=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=FvV1UgyoeE6fRzjMv3sXXk6B0jHC5qSJlGvcHlSekhKmFBYVXlsrFNQX62R/TJqeNtzOY4D2YlKVSNiD02iOfjoo3hlxNdfkZEkZ4v6OJCGuVSO1WW6iLdXsEu+9OeJw0W1eWstTp7mnLw9+3D1QLI4V5wY7+kM/E5+f2DnEha8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=googlemail.com; spf=pass smtp.mailfrom=googlemail.com; dkim=pass (2048-bit key) header.d=googlemail.com header.i=@googlemail.com header.b=nbUz0bCs; arc=none smtp.client-ip=209.85.218.46
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=googlemail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=googlemail.com
Received: by mail-ej1-f46.google.com with SMTP id a640c23a62f3a-b6d5c59f2b6so856189366b.2
        for <stable@vger.kernel.org>; Mon, 27 Oct 2025 20:02:29 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=googlemail.com; s=20230601; t=1761620548; x=1762225348; darn=vger.kernel.org;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=0qNkBOdLmm1kj4SMMo8wWk+UdIPzxQ3y5CFJL8sjPwM=;
        b=nbUz0bCs43TeU9zpUE6EhJTucpEiZp+Nx0nNdK/WxMsuckf9KFX55M5nQ3lh83XNc4
         aTnooLHLe1fdq7cJ0iCVZag73NnDP5wexvYM6eX0zYasRwP4o0kN5tl69UtxR92bensi
         ih1wYswRR2c9Yf0JQFSXt6FZLwV0kilQFi1ToWbl7qUEMMOfqr8LdN7/r/MLF08zOM22
         lAa4iF2HcSJLp02HqAo590nRlumZWXqmSlcpPO9AsdtSs/f5EXctuehUSErSobNIvOP1
         ysSn+AI0E4JjzC0lNyEkwXhsjx2vG8rCFQvjigeeJZKQArNXztPvd5J1XaSsj8kSkdrE
         +6Vg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1761620548; x=1762225348;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=0qNkBOdLmm1kj4SMMo8wWk+UdIPzxQ3y5CFJL8sjPwM=;
        b=uYTBVZRnEHmhGnMoJ4wQ7CuNm/UOuv+MlAr9wtBp4HPokVcv0RA4PykQe65UPVF4Kq
         YH+JPtAts/S3OMftfudCyMpBkKuXbDfqlfxvnTKl9PdffKMRjlOq6Wkgsd818aErqRM8
         fBzjKAfhiSNsj8dYOZMBjncpF3+Bi8H+ak4kdLmlgqpQX1xB3d6hXvkmTy0H1+c30TCK
         JfUwjR7vDYofnJJgPwS30QEBwbk4jTOXFzmdc/bFbaXJ0bPS860XK/QBqCURSD+1Xwfr
         tcj7ZR50zWBYJwvk2KIwx5BIJhkmrvfZHFvhbz2WTPsBiZILcmlwqHwM+kk+j3Cysb7Y
         EnEg==
X-Forwarded-Encrypted: i=1; AJvYcCWq9mgAm7GrdT42smoyX7lgr9Hdc5KA1mxS+/qcRO3a3EZn3sqbvKoHOL6M1HDJYXrxJYmAcpU=@vger.kernel.org
X-Gm-Message-State: AOJu0YwVZ61cyrCt0ZGWtJ0MZIK9Dj8yBN38G6Q25HPNHijuB0yyvCSr
	E/MJA6TIJqqQjxKktW5WTzbD/8m4ssPaUAs6J9lFQiF0BPCo9kPN6tc=
X-Gm-Gg: ASbGncsL1yNWdBYR8FtZMmuaSwBfoJ2uSz1jS6CALc2HZI3g2G7gnJ42esTSRHgLqg+
	S6CRdCkPid/5qpYuYGfvBi8aK4/5z9GUEvF9u//Js58BwIKzojcjtVwDVTalofM7Uor167wu68A
	UPAbaYRsRhfvOx7tMuEZPKKYFOXcvMLTWFCj07wtjuZEpYllO1rWzcSBE8g5eGioXVAZkZ+onQ+
	DRqBxW3/W6iB23y+Jn0FSf4T/V5oqrUsgjnavlnlizkDPK1pmic39jOvZIOnU3U8vKQfD1SrXw0
	8luPbbnx+LX5o4X92RLOTDOYKZj70VoHW+K/f0ViXTa96Lp8sEBcCvfyJ2uoYK3g51/0oe3vqzk
	DgLxBJaKQv1wwt5cfrmyuoidokV4Gxan3vyN/ntgQIrMoEusvfVgB9GOI72QVJa2ZfYsQ4kJcec
	7eUuDwTeTvFZJT5OoDcqkNiCXn6PmiqKG/4iKSpEZMLzUDkliW6ZoZAvSiZgKEAQ==
X-Google-Smtp-Source: AGHT+IHxBrrkSgnPojKFk8DgeU17os4fisUtn00kUYf+BNJ8a3sIYGRtzo5x/Ym39RIAZ6PoQzKXCQ==
X-Received: by 2002:a17:907:9482:b0:b3d:73e1:d809 with SMTP id a640c23a62f3a-b6dba5a566cmr262777566b.48.1761620548327;
        Mon, 27 Oct 2025 20:02:28 -0700 (PDT)
Received: from [192.168.1.3] (p5b057a53.dip0.t-ipconnect.de. [91.5.122.83])
        by smtp.gmail.com with ESMTPSA id a640c23a62f3a-b6d853386d8sm936725566b.18.2025.10.27.20.02.27
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Mon, 27 Oct 2025 20:02:27 -0700 (PDT)
Message-ID: <4589b95b-5eca-40f6-b014-6e90db486b17@googlemail.com>
Date: Tue, 28 Oct 2025 04:02:26 +0100
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Betterbird (Windows)
Subject: Re: [PATCH 6.1 000/157] 6.1.158-rc1 review
To: Greg Kroah-Hartman <gregkh@linuxfoundation.org>, stable@vger.kernel.org
Cc: patches@lists.linux.dev, linux-kernel@vger.kernel.org,
 torvalds@linux-foundation.org, akpm@linux-foundation.org,
 linux@roeck-us.net, shuah@kernel.org, patches@kernelci.org,
 lkft-triage@lists.linaro.org, pavel@denx.de, jonathanh@nvidia.com,
 f.fainelli@gmail.com, sudipm.mukherjee@gmail.com, rwarsow@gmx.de,
 conor@kernel.org, hargar@microsoft.com, broonie@kernel.org,
 achill@achill.org, sr@sladewatkins.com
References: <20251027183501.227243846@linuxfoundation.org>
Content-Language: de-DE
From: Peter Schneider <pschneider1968@googlemail.com>
In-Reply-To: <20251027183501.227243846@linuxfoundation.org>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit

Am 27.10.2025 um 19:34 schrieb Greg Kroah-Hartman:
> This is the start of the stable review cycle for the 6.1.158 release.
> There are 157 patches in this series, all will be posted as a response
> to this one.  If anyone has any issues with these being applied, please
> let me know.

Builds, boots and works on my 2-socket Ivy Bridge Xeon E5-2697 v2 server. No dmesg oddities or regressions found.

Tested-by: Peter Schneider <pschneider1968@googlemail.com>


Beste Grüße,
Peter Schneider

-- 
Climb the mountain not to plant your flag, but to embrace the challenge,
enjoy the air and behold the view. Climb it so you can see the world,
not so the world can see you.                    -- David McCullough Jr.

OpenPGP:  0xA3828BD796CCE11A8CADE8866E3A92C92C3FF244
Download: https://www.peters-netzplatz.de/download/pschneider1968_pub.asc
https://keys.mailvelope.com/pks/lookup?op=get&search=pschneider1968@googlemail.com
https://keys.mailvelope.com/pks/lookup?op=get&search=pschneider1968@gmail.com

