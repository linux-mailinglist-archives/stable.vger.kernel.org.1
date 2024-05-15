Return-Path: <stable+bounces-45150-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id B2A408C62ED
	for <lists+stable@lfdr.de>; Wed, 15 May 2024 10:36:46 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 441C0283F90
	for <lists+stable@lfdr.de>; Wed, 15 May 2024 08:36:45 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 44BC64AEF2;
	Wed, 15 May 2024 08:36:42 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="IC4zyqiT"
X-Original-To: stable@vger.kernel.org
Received: from mail-ej1-f54.google.com (mail-ej1-f54.google.com [209.85.218.54])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 86AEE47F7F
	for <stable@vger.kernel.org>; Wed, 15 May 2024 08:36:40 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.218.54
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1715762202; cv=none; b=NA/8RxP0CyER9iXXEY/x21nm2ATO0anNHLrb0jc3JAdnJxoF22juurPoY6du58g5h4N3U5QhxypQCRc83Sx8JxD030+FiRxqIBqbJQxOvXu9riIkqENsZ/JInvAOTUKuf7nH6rs1iPEFGhA7gGOdbXTMTMzJRbEZVf1/1nS8EA4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1715762202; c=relaxed/simple;
	bh=6ghq1S/OR/AtfJd7Tsg5P5LLIt39QpQKw5aZqTQEFjA=;
	h=MIME-Version:From:Date:Message-ID:Subject:To:Content-Type; b=EgZ7+3KQD1lvHI81ljQRIQT5JyYQ7u8XdZiR24JoOwUFO85NxBlfncI7tNDQGm/SKOFwSSAdkkPqIBWa/4Qk4ujzrCYJqqcaYmKV8Lk6/qBWfVUA2f5ZGEtZaIKTLZqNyWGlUzeFBnSlafK8GFO51drvQVvY4jcJKQoK9G3YayQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=IC4zyqiT; arc=none smtp.client-ip=209.85.218.54
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-ej1-f54.google.com with SMTP id a640c23a62f3a-a59c0a6415fso141527866b.1
        for <stable@vger.kernel.org>; Wed, 15 May 2024 01:36:40 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1715762198; x=1716366998; darn=vger.kernel.org;
        h=to:subject:message-id:date:from:mime-version:from:to:cc:subject
         :date:message-id:reply-to;
        bh=jEj9jgWOJ5ehU8u5+TkCq9cmFnlrDKKgkcPh9V/A39E=;
        b=IC4zyqiTUcgXw4M3sy1FzRuKJ+CuPGfWx1ktIR4M/jtyeWRfex8togQk+2y3NTWjFh
         h0D2POvar1H6H8uP85is/JRQGWujIL8fdc76+YeY/phRZTwI2QUfOcq7T1h4yW2d0B5+
         yPrjzIKJWv7l1hFFSnHcOPPI1LgUb0dXPb5IoAgP+q+YF2qdoEb2841bINztBX6z3ThR
         qMdEWuhz3vzWBLzIYE7AdsGx97zPm9ld/STBykvRpOLPrQ0wxm0w6OmyYnlx/ChgHCjx
         /ooua7Cgy6IuYOgB/dlqmCUQ0rwM1r4DCE4YMt1/0dbPJ+nR6bKm4xjXbKw2oiThYt2g
         3BMg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1715762198; x=1716366998;
        h=to:subject:message-id:date:from:mime-version:x-gm-message-state
         :from:to:cc:subject:date:message-id:reply-to;
        bh=jEj9jgWOJ5ehU8u5+TkCq9cmFnlrDKKgkcPh9V/A39E=;
        b=m5rwaw1pG2WJmA4widQj2/J+PJ+BJAazGRmtkmtOtKse0rlPrIbb7JVks6oCwL/4zI
         itQcSNsVsn0891Ql7p3AWMIHbUn64eeNQ2QRRj25f29xI81sNyb6dgIyIoopXkDiqlB8
         r2YmYD0vS5VMGYfCeyVaWvYxlNJ3RlrAOAvXMHatdH/LMpfmcVJTnCK+fl8kKc6p5ZqX
         ONWE0gHcVpnS3fI7PHp15uhezdlGstOHwlSbGOF1gUoo3aGtM6dNCB7+vg3RYnReoYFf
         9nVHpw3C/LlErn4zPIGZ4lMTijAhrvxJD8KCDYaIyJ0Wck67aPVjmHLQO3tZni+FyHgN
         GjQA==
X-Gm-Message-State: AOJu0Yyd+Dthevpi97SBQZ4hN3NEi/oIdxEACm9ejWLvYXhJHe61RVqE
	Zj5R4MbOEW70hqy/c8DGCRLrDoog2xb31r+ixgle3wvfWEU94xS706ZOAworhysfoxyjG0HHTW3
	SSIiMQMLuTGC/gQkjfamLI1u6X2Lgkxq4
X-Google-Smtp-Source: AGHT+IF9uKgXgK7xHsS4vLRMQhZsWrQOAFNA/aeukkdZWCi4xPONe/gGQu+N70SsX0mvOb2G833Ca9Aa/HZiYPKw3i8=
X-Received: by 2002:a17:906:3bd1:b0:a55:a072:1ab8 with SMTP id
 a640c23a62f3a-a5a2d55e3damr1043969666b.27.1715762198469; Wed, 15 May 2024
 01:36:38 -0700 (PDT)
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
From: James Dutton <james.dutton@gmail.com>
Date: Wed, 15 May 2024 09:36:02 +0100
Message-ID: <CAAMvbhHra1jpjgR69_+91J2zTCayf_mzodD93XKGiLRGHoy2Pw@mail.gmail.com>
Subject: Regression fix e100e: change usleep_range to udelay in PHY mdic
To: stable@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"

Hi,

Please can you add this regression fix to kernel 6.9.1.
Feel free to add a:
Tested-by: James Courtier-Dutton <james.dutton@gmail.com>

It has been tested by many others also, as listed in the commit, so
don't feel the need to add my name if it delays adding it to kernel 6.9.1.
Without this fix, the network card in my HP laptop does not work.

Here is the summary with links:
  - [net] e1000e: change usleep_range to udelay in PHY mdic access
    https://git.kernel.org/netdev/net/c/387f295cb215

Kind Regards

James

