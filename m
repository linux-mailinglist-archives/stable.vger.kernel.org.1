Return-Path: <stable+bounces-116460-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id 3554EA36886
	for <lists+stable@lfdr.de>; Fri, 14 Feb 2025 23:42:10 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id A0FF67A1B4D
	for <lists+stable@lfdr.de>; Fri, 14 Feb 2025 22:41:12 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 751321FC7F7;
	Fri, 14 Feb 2025 22:40:32 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel-dk.20230601.gappssmtp.com header.i=@kernel-dk.20230601.gappssmtp.com header.b="tCTVgANf"
X-Original-To: stable@vger.kernel.org
Received: from mail-io1-f50.google.com (mail-io1-f50.google.com [209.85.166.50])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2A7031FC7CF
	for <stable@vger.kernel.org>; Fri, 14 Feb 2025 22:40:29 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.166.50
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1739572832; cv=none; b=VGyRnq5ezps+xvExMN/F0iPSTOQu2qU7oeS4S/ZgFn5JUwQqHAzUivDW5X7x5na96C6NDQfqLCZLaLN0Jg0eOEmW9yZIc69t4O5UD//+AGQrJaQkrHD8eS9i/w2O4B7iaFdg/TsO4Nfx30k4RJ1Ty5x4GrjLVqfW5//vIFAxM9k=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1739572832; c=relaxed/simple;
	bh=ZGObRox+8WuLTA6QeatV3WsGq0mEh5JfGFT8vjpr7rU=;
	h=From:To:Cc:In-Reply-To:References:Subject:Message-Id:Date:
	 MIME-Version:Content-Type; b=DywPj5QV1+v1RSnDlUdrj2dJMynl5dOALQ35E3G5aRADIoIQdFaedH2hCxx8mnyBc15WgqgeYyOBC5LxN7Vih+9pRjzI9fUchxI+hQLSgAy26TDOw/meEogOxMEOnk31/EAgtQR/ujwhaNP7XQaalt3tb/80PKxZYTygGv2ElNA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=kernel.dk; spf=pass smtp.mailfrom=kernel.dk; dkim=pass (2048-bit key) header.d=kernel-dk.20230601.gappssmtp.com header.i=@kernel-dk.20230601.gappssmtp.com header.b=tCTVgANf; arc=none smtp.client-ip=209.85.166.50
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=kernel.dk
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=kernel.dk
Received: by mail-io1-f50.google.com with SMTP id ca18e2360f4ac-855184b6473so188237739f.2
        for <stable@vger.kernel.org>; Fri, 14 Feb 2025 14:40:29 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=kernel-dk.20230601.gappssmtp.com; s=20230601; t=1739572829; x=1740177629; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:date:message-id:subject
         :references:in-reply-to:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=fa9W4XHgghBrAnH97Pbhz4mqOnDw6PjIeBtYFOVDltw=;
        b=tCTVgANfRISSBx9vJ38yf/qwrTr4/l/spAq2gzkpW1DKnBTXrT5WpnAQ7ofZO08Zo2
         F6FjriyAuDfKpoXM2HDtXqXI2f9awtmyAwb4zm5mCuS/7cP6/vSeKfEbwP5g2JEUtoc2
         K7mNU5GQc8b+lPTg5yi7LRf06CVbJJ5g5Ofs9S4MiTS7xrkq71qh41pr/zL/DAfn9bcP
         njadFNXzZ3yj3rjoWzQ5VBjMLMgMbktGERGrolXrtxLwHgUzrDTnBl3f5SMBjKrvKRjA
         RUaJylwEbUXm0aGsdf12orSQLcVHmn/hSFdk0/Pm1oG2yHAWqjWTtB9vJJAzScN7hSar
         OCqw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1739572829; x=1740177629;
        h=content-transfer-encoding:mime-version:date:message-id:subject
         :references:in-reply-to:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=fa9W4XHgghBrAnH97Pbhz4mqOnDw6PjIeBtYFOVDltw=;
        b=ZTcAccGLiq5mPrcT0NiKTk8LPKaLa2OEtbcBWMz597eYjwGFTTdZExbSTHP61R9wR0
         zNt6tQcLsBZ2M/7OgKF/nz84oK1AdcI9VAdCLC2pyCXK4HC+2yXAUcX7ZFgxT/Jp3FNM
         TSD5uv9/+QFChkgs03FiKnLpLigzJdClU50RZvJpaYDb/wAbZvynfAgT627nvbqrbwTo
         +EtqVJdzUe105FQlA9if55zZmMtrKyO6IyOweoP/c+C9vsGgdXX1PVXxFNV0htseR2aW
         Odt7XMrdXIFz7X4ur8rDx5F6CzBmyqt+LGBpQOcgxWJsIQ4ERQitd0rSFo7oqU5OJVFu
         JV3A==
X-Forwarded-Encrypted: i=1; AJvYcCWn4QEdD92ldJ3jF9aO0de1ud1CHLtDgaUjK82QnISrBcoYDmZXAB5KBPayiF87g/dcu9yGUqk=@vger.kernel.org
X-Gm-Message-State: AOJu0YzedKShipb37yswtkmn2UdBMafXFuNuYGVqxeQSvQEnxloWxzaQ
	gV21DTnvmBYGYg6YwsGng0ussJFCiBNrXQnjLX+ZusiXgHljiMbqyELByH+suUA=
X-Gm-Gg: ASbGnctZzIAuw8kCak1wq43Z0GXTrOJtUcW/HiVAWAws3pWYmZYlyrsa7jwqgQeXHnW
	jx2AuKuaF6NFuqD2x/WsURclmwZVGgyBBLpUKtSp2sXiAg8YaYBE0hk38Y+kU+tEsQeAcc+s5KR
	sJm5MdpmCHLQq5U++ZMKD0Q5A2FQdPHQ0hPxk/Nqk3DsoWeYxlMGjRBkCX2HSYCF4xM+KsRh3JL
	OB/wdbmFCyDls6aoPDg6/v2ZWj+S85eGATat5pMChhL4m87ut1qm6OcU4HEgb0vv1/udK+V9DWG
	0zuEqM8=
X-Google-Smtp-Source: AGHT+IHo/sDO3CzWbsrCfscoivDifZjkD5COpzMt+rasMWA5MnAVrwjSI6GkP5oWPdKyiGiLtlm3/g==
X-Received: by 2002:a05:6602:6d03:b0:855:7832:61fb with SMTP id ca18e2360f4ac-8557a0dbeb2mr134971339f.3.1739572829287;
        Fri, 14 Feb 2025 14:40:29 -0800 (PST)
Received: from [127.0.0.1] ([198.8.77.157])
        by smtp.gmail.com with ESMTPSA id 8926c6da1cb9f-4ed282affeesm1020648173.91.2025.02.14.14.40.28
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 14 Feb 2025 14:40:28 -0800 (PST)
From: Jens Axboe <axboe@kernel.dk>
To: Jann Horn <jannh@google.com>
Cc: linux-block@vger.kernel.org, linux-kernel@vger.kernel.org, 
 stable@vger.kernel.org
In-Reply-To: <20250214-partition-mac-v1-1-c1c626dffbd5@google.com>
References: <20250214-partition-mac-v1-1-c1c626dffbd5@google.com>
Subject: Re: [PATCH] partitions: mac: fix handling of bogus partition table
Message-Id: <173957282830.385288.5820409491649052216.b4-ty@kernel.dk>
Date: Fri, 14 Feb 2025 15:40:28 -0700
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
X-Mailer: b4 0.14.3-dev-14bd6


On Fri, 14 Feb 2025 02:39:50 +0100, Jann Horn wrote:
> Fix several issues in partition probing:
> 
>  - The bailout for a bad partoffset must use put_dev_sector(), since the
>    preceding read_part_sector() succeeded.
>  - If the partition table claims a silly sector size like 0xfff bytes
>    (which results in partition table entries straddling sector boundaries),
>    bail out instead of accessing out-of-bounds memory.
>  - We must not assume that the partition table contains proper NUL
>    termination - use strnlen() and strncmp() instead of strlen() and
>    strcmp().
> 
> [...]

Applied, thanks!

[1/1] partitions: mac: fix handling of bogus partition table
      commit: 80e648042e512d5a767da251d44132553fe04ae0

Best regards,
-- 
Jens Axboe




