Return-Path: <stable+bounces-12193-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 5A4D5831C95
	for <lists+stable@lfdr.de>; Thu, 18 Jan 2024 16:31:18 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id EECC01F241D3
	for <lists+stable@lfdr.de>; Thu, 18 Jan 2024 15:31:17 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id C28C128DDB;
	Thu, 18 Jan 2024 15:30:46 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="BSriI94n"
X-Original-To: stable@vger.kernel.org
Received: from mail-oa1-f47.google.com (mail-oa1-f47.google.com [209.85.160.47])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 52E7228DC9
	for <stable@vger.kernel.org>; Thu, 18 Jan 2024 15:30:45 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.160.47
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1705591846; cv=none; b=hkZYT8DkNNx54w4F8/vjGEDRdl0AiETFK5lqiHxhxRV5BpiGXGpW0ijrFLUYol7xP25RGrn8fySformuis5twI8V44Jt7VCPk24Mh4LkWosgK0FdNJZrqx+BOBlJrUsBa8mQsLqbh2B8S3yCtACm8O+us8hIM6NjIRpLsS3wTZA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1705591846; c=relaxed/simple;
	bh=/ehlJVuBkx1l+7fER1WfZoln/Q07Kd9+puf2rGzvQrY=;
	h=Received:DKIM-Signature:X-Google-DKIM-Signature:
	 X-Gm-Message-State:X-Google-Smtp-Source:X-Received:MIME-Version:
	 From:Date:Message-ID:Subject:To:Content-Type; b=LodMBEaz48lcXSD/Cc7BlfXwGHF7oQ+wC48Pf+9uxxhLOTo3p5dWGceYkn0FRMeSa1520J863sIb+OEfk7j0PLNhM8OP9CwAkshjLIzWqBg4PlvVIa9L0kOrZsU5LqfRXNV2OwWrAjN4dWDjwKjbVvqkKsUM0A+r35hZz7zr/HA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=BSriI94n; arc=none smtp.client-ip=209.85.160.47
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-oa1-f47.google.com with SMTP id 586e51a60fabf-2107f19e331so1483935fac.3
        for <stable@vger.kernel.org>; Thu, 18 Jan 2024 07:30:45 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1705591844; x=1706196644; darn=vger.kernel.org;
        h=to:subject:message-id:date:from:mime-version:from:to:cc:subject
         :date:message-id:reply-to;
        bh=/ehlJVuBkx1l+7fER1WfZoln/Q07Kd9+puf2rGzvQrY=;
        b=BSriI94nJgm4TWAquz+/4YnPQOcZLBO5kxFUuo0E5u8lZZJyXRYjX3Cxa/1+2DMsTq
         bX6p6b33EkwwojZHbjA4NavS2gCBLQWAJ0/uCaaKuEJt+wP172uR0//q7wv29kaMHIuM
         VCgoFJ+FpVC1vLd37B6xS6P7dkgKPFlR+ftuS2E9YkPx0y7uywDxVs72oWelkFxGwaz5
         9g15bFaLleiFjovnBtR1XxpakJl6cCgYsSsnKLsiZEb/o3zelnoGdreRYQn+GDGDcb3X
         x60q9edXGLlhhY+TNbBh0IGrwH4NBGCDtuT6eIHV8064YSSwCoYWda7l9Yh8yt6Sq2vo
         q5LQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1705591844; x=1706196644;
        h=to:subject:message-id:date:from:mime-version:x-gm-message-state
         :from:to:cc:subject:date:message-id:reply-to;
        bh=/ehlJVuBkx1l+7fER1WfZoln/Q07Kd9+puf2rGzvQrY=;
        b=RPhruCfbcjHI+DTwllFr+IaSGfYlaI0xgnMBB8AW1Yt9WmOhWt/opoRmSOLyVDRaBi
         sZGzPRcFezHDo/1Zvp9kB6WUVzODe4p9SWo09GLdGcvbYm8sLLYySGS7aCk6lz5Mo5O1
         lKfdkGXSM9K8ilbP1mTXkHbt29dE+YH2Z8E/mpbhRS48co0UkXBJ/ofnfqq7dUhvOBTk
         LF8c5BSuYz67pf7sK9wQV2qms7G6bMBAkkKIx9A0GNELVtes8n8uFRaPIg1nlWqvH4Vp
         Fy62GWvJ1Fxuzgqo6K7zOU/9CTsjzvDgl87u8dms/cp0tcJp2mahUBxXvMhCFbpMj4gL
         CPDg==
X-Gm-Message-State: AOJu0YwlWgbt0R9OJcVKzZ8vKiC/lvhySE+gRLW5SW34MGvhnFEnLlo+
	g59ZiC07m1xzdJVQQX9yg0s6uZUgwJQEB629Bz6CoaRRHS5GDinHBu3cJ42cV/KFup6i0Doa81W
	TcRhr8etO8uTPO0Yvaz/29ucuPu33HHQ7GpQ=
X-Google-Smtp-Source: AGHT+IHkZB30wP6D5yfWdxNmlllEAgJZ6J15csIhnxCOO8DDE+TLxAi+xXjBVslHCo2Gcll6XTFzX3BLTjPAcVuTht8=
X-Received: by 2002:a05:6870:d189:b0:210:af25:a5a0 with SMTP id
 a9-20020a056870d18900b00210af25a5a0mr855695oac.1.1705591844302; Thu, 18 Jan
 2024 07:30:44 -0800 (PST)
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
From: Alex Deucher <alexdeucher@gmail.com>
Date: Thu, 18 Jan 2024 10:30:32 -0500
Message-ID: <CADnq5_MYFeuVtaCMVo6wuy8tXn6iui1sGRLANfc5FTmcaHW8Lw@mail.gmail.com>
Subject: Revert "drm/amdkfd: Relocate TBA/TMA to opposite side of VM hole"
To: Greg KH <gregkh@linuxfoundation.org>, Sasha Levin <sashal@kernel.org>, 
	stable@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"

Hi Greg, Sasha,

Please cherry pick upstream commit 0f35b0a7b8fa ("Revert "drm/amdkfd:
Relocate TBA/TMA to opposite side of VM hole"") to stable kernel 6.6.x
and newer.

This fixes a segfault in mixed graphics and compute workloads.

Thanks,

Alex

