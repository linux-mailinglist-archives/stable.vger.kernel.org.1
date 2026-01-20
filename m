Return-Path: <stable+bounces-210474-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from ams.mirrors.kernel.org (ams.mirrors.kernel.org [213.196.21.55])
	by mail.lfdr.de (Postfix) with ESMTPS id 61946D3C513
	for <lists+stable@lfdr.de>; Tue, 20 Jan 2026 11:24:45 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ams.mirrors.kernel.org (Postfix) with ESMTPS id 68B0B589ACB
	for <lists+stable@lfdr.de>; Tue, 20 Jan 2026 10:13:10 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 0F6653D667C;
	Tue, 20 Jan 2026 10:12:47 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=spacecubics-com.20230601.gappssmtp.com header.i=@spacecubics-com.20230601.gappssmtp.com header.b="DNY8cahH"
X-Original-To: stable@vger.kernel.org
Received: from mail-oa1-f41.google.com (mail-oa1-f41.google.com [209.85.160.41])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2884F3C008A
	for <stable@vger.kernel.org>; Tue, 20 Jan 2026 10:12:44 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=pass smtp.client-ip=209.85.160.41
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1768903966; cv=pass; b=upRKBcZlkhpvx3oF4yYs9ztacE84l/Td3f++Lz8bOJyFz5+rOGrQTE99BanWjb//MWF2bI5S9dCTm5SHow8fSIlGiScXbo4jLDds/WAe+luqUIHEpDE+Mvb0wZDEqPhRinqQK9R8McNXEC53IoBNCWtVlkWNSIjHDyq9qpw4kuQ=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1768903966; c=relaxed/simple;
	bh=QE8zcIP9hsC3ke9IyUqkzncH8PRCpWKNkwGFIBq7oUM=;
	h=MIME-Version:From:Date:Message-ID:Subject:To:Content-Type; b=KaCxv7aoxCgd+x0rnfyf5Ns4F+rhfqjedS+fb0Q5H2CZgwtXIiCbjOhMHFezM0nvBEZcsPVmtTm2KKBR5OtBkk3tw0UyHHsBUztwc7Q5KzGBgwjOx/HtBw8uTA0NGsU1p9LhSHvviD8EZqimW2ciMlyZ/xDyN+/xpcgCopZK8jI=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=spacecubics.com; spf=none smtp.mailfrom=spacecubics.com; dkim=pass (2048-bit key) header.d=spacecubics-com.20230601.gappssmtp.com header.i=@spacecubics-com.20230601.gappssmtp.com header.b=DNY8cahH; arc=pass smtp.client-ip=209.85.160.41
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=spacecubics.com
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=spacecubics.com
Received: by mail-oa1-f41.google.com with SMTP id 586e51a60fabf-40418578e28so1895132fac.1
        for <stable@vger.kernel.org>; Tue, 20 Jan 2026 02:12:44 -0800 (PST)
ARC-Seal: i=1; a=rsa-sha256; t=1768903964; cv=none;
        d=google.com; s=arc-20240605;
        b=h7RjHlpt5+yPLjtDKqbcAq1LttUhe9YAHOvNJZpiMoFsMTpMhSxcy6oLwyfxNH04GV
         5PJWUlijW7NmEyeqfBFpB4wohmkcaS+qYFDQujpRccfgLQ4uDfwTL4uuH/DOJbLXdftO
         qLYoiBfrfpP3HMLy6mXS5C6y/Xm9yWQ8T3LMi2JirQLakwcDcHHEhfYahBMJj13VBW0z
         QzNen+Go67xBweBDf8MbNX+lxbQpk7Et8XY2NHHI5GiOeCvuXjhsFT0WoeiAtBpLIyH6
         6FoY4PDIttFOtHxQsOcZun6V8ajIQcAZ97EIVKG2JHOr5EuVlEduNt6X5443bBqNb6zz
         EpDA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20240605;
        h=to:subject:message-id:date:from:mime-version:dkim-signature;
        bh=Q80em5AhaoOsv/i4O9WSgxJ5iE37nwBXRddmcmckF0U=;
        fh=RvEWwL4CdzthXqFPrJY1v5EhszSUJtREhzms1oh7XMQ=;
        b=Iy3B2jEkf+83yVPYulABXieqGS4G4KybfDI5q44J4EbaOVHrnF2LLSmWGTWtgDRc4s
         25RWqvsvAwzaJiUw1+pXHSqZIsK/fAVUZ6N5IftNOK92Aqe9Xr3oX0o5P802XwF8tXZ/
         aR1e/U/r09SGYN/Qncv9Z/wC0S2m3uis0dnzInXIQIHbjOf8OUbXnfGwghcC9q34f1An
         HS9kdvn8zcAwmAesk9lxX1k/99mCpmh6P5hY5fGFrj9DOVxQEJPFEtKzAD8JXTvAMood
         tfnGJpP1ZQgHMEWxhn+UwLWdN3NKfKy7lUkwY6luZ7Cvkjkm2Fuf9wZ3Weujq4iBTr6f
         ZABw==;
        darn=vger.kernel.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=spacecubics-com.20230601.gappssmtp.com; s=20230601; t=1768903964; x=1769508764; darn=vger.kernel.org;
        h=to:subject:message-id:date:from:mime-version:from:to:cc:subject
         :date:message-id:reply-to;
        bh=Q80em5AhaoOsv/i4O9WSgxJ5iE37nwBXRddmcmckF0U=;
        b=DNY8cahHdzPDCRjgO6i510NeLmT7u8ve32XxQ4Rl86komb2j433AZz2PM0+lUBJAkl
         4/Sj2Lzdf32R+6vz4GYTxNib4pDpYrSlqp+RpKCjqIFK5Xppj+I72CtLbIzZBcqkXCa3
         6GgPzzSoqXG49Oyjb5mcZSkUovb0UdMR93byG6vEQApFeIlHgx5Xnt4Eh70O21Che+Ga
         BcWrkI9Ou+uVTiEGzdgog3XxxTvTuYg2D1TRAg7xrgn9rBeBwqlS5CsCmhIpkvorxCkS
         UxZIiF1fHa2QWyF8oF99UhPLPQtEADvbrnzarI7HvCaqRbyYfyVa6E3IioS5MdxafuL6
         QG2Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1768903964; x=1769508764;
        h=to:subject:message-id:date:from:mime-version:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=Q80em5AhaoOsv/i4O9WSgxJ5iE37nwBXRddmcmckF0U=;
        b=J8YkMG/OskBR793JlZ/32NmsT698ISLDgbxJsKz65BA7GI2j3CH6GFzJEmz2Poxn0t
         K3YTALr1LZ6mSwOcLLuy6PVnygsNc5VXCrd1kNPZZNlpBO3hnDqeWoY62ZYQPkaQDd/c
         VUwzL5cw10dzxm8QSPkC3Ifgb1F1gDZg5HAR21qhAWF8qxpsaxO0b2tlPE8LZC0ilZsl
         Qob2Tp1uQczMnTbQBAtxTJmiDjt8hwMRLUdsvqK+VTtHvCdmyeOLcR/GdGNpkP8DQz6O
         CgQT86WLcuilpouT3OaG5YrVoH4V/xDm595Qf+QJ0j2w64YuuGQuj4wJK1KWau4pD4UF
         noaA==
X-Gm-Message-State: AOJu0Yz6b7gLyGZ30mqjhYhJHFlVjEESoxlN0qeVVjA8r9quGCUPbtV2
	xjtpuWB6hHkhVVgWI8UuUxM5g8Wy/ZyE9IFBHi2G+BlEaO0NJFxj02XtaaSPnQDvfJ9cij3zmzA
	DxOWbhcQUEatiuuDfgrBUbjp+apMVYQNc0NBDIG7ZfiLyxZ4z89vzr1w=
X-Gm-Gg: AY/fxX4NCBDQdLUgaslRMkIZX/J73vVTYtVYqm5iacaSpSGzvsZgrFbITEMCjQJXoVu
	A57J5E5wBVedw9a7PL1y1IV80/SW7/3kD8XF/XPySqFSG0yUELTJxRCFzVxCfbJrTQtPkbvZakE
	5iQvflPqZdJKwqoGuOc61MsBExhd71mljkvvxyeAk7CkjiOKI5q7QN3jPm2oaM2lhKqZechCKv+
	v1iBdJ5GsUiNpt2CD/fK2h47E45wGbqktxvTL8lR0KmAu7Lpcz22FTban24jXuKM333CTSX
X-Received: by 2002:a05:6870:831f:b0:3ec:8851:54d2 with SMTP id
 586e51a60fabf-4044cdfb96fmr7249677fac.21.1768903963876; Tue, 20 Jan 2026
 02:12:43 -0800 (PST)
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
From: Yasushi SHOJI <yashi@spacecubics.com>
Date: Tue, 20 Jan 2026 19:12:32 +0900
X-Gm-Features: AZwV_Qi7i08wQscDx24eGpuwY73mWj4O6CAIEFuN8dpbtr4mBzxA3AxA0gdNtFs
Message-ID: <CAGLTpnJhAgNThT=gWcpLEEFvNBwav+N=4Kf1yQK2O7T823MzEw@mail.gmail.com>
Subject: SPI NOR: Request for Inclusion in v6.12
To: stable@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"

Hello,

Please consider including the following patch series in the v6.12 LTS release.
These patches fix issues with the Spansion S25FS-S family of SPI NOR:

- e8f288a115f48: mtd: spi-nor: spansion: SMPT fixups for S25FS-S
- f74de390557bf: mtd: spi-nor: sfdp: introduce smpt_map_id fixup hook
- 653f6def567c8: mtd: spi-nor: sfdp: introduce smpt_read_dummy fixup hook

These patches have been tested on my Xilinx / AMD Versal boards.

Tudor Ambarus of SPI NOR subsystem maintainer allowed me to submit
to the stable tree in this conversation.
https://lists.infradead.org/pipermail/linux-mtd/2025-November/111104.html

Best regards,
-- 
            yashi

