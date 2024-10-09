Return-Path: <stable+bounces-83128-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id 98007995E3F
	for <lists+stable@lfdr.de>; Wed,  9 Oct 2024 05:43:32 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 1CB14B23C55
	for <lists+stable@lfdr.de>; Wed,  9 Oct 2024 03:43:30 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 3F49A13E04B;
	Wed,  9 Oct 2024 03:43:24 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=canonical.com header.i=@canonical.com header.b="FMxKVyQX"
X-Original-To: stable@vger.kernel.org
Received: from smtp-relay-internal-1.canonical.com (smtp-relay-internal-1.canonical.com [185.125.188.123])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 81C513207
	for <stable@vger.kernel.org>; Wed,  9 Oct 2024 03:43:21 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=185.125.188.123
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1728445404; cv=none; b=dft+atXYo9TJ8KldE/k95PX/n6nnyQCUM7FAa8U9YzBET4v6jMf27Xwupl/EWnw8b2+aRxcgTZZoxWDURHH1Rx3d2eKDmRaw0+rF5jR7qn576mI+B2o6Lb/oG3FDzzxbmVk5n8Zs4vzivivREa3n+eKeNnEq+3AJGx66RnQoXKE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1728445404; c=relaxed/simple;
	bh=Wu6V81u5IdzY9vDfmZ+mK35ruk9Pmu3dx+Stw0yT0ZE=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=Ntj0wGauNM83GRcX/XyJ4mbtbAwiMz/lQ5zAFYXXNnmaBvU+V/56ZjKBDAOVdl3ou2znSvtnlDmQYwE0FvIDe5HeSATrCFtvZ0I3O5kuW8ZdKQ+TjD5c9RVqfX1QJBefjFunoGI3MWm3kvRnYSF0UnSYHhI02MgIfH0WfVmNQm4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=canonical.com; spf=pass smtp.mailfrom=canonical.com; dkim=pass (2048-bit key) header.d=canonical.com header.i=@canonical.com header.b=FMxKVyQX; arc=none smtp.client-ip=185.125.188.123
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=canonical.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=canonical.com
Received: from mail-qv1-f69.google.com (mail-qv1-f69.google.com [209.85.219.69])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by smtp-relay-internal-1.canonical.com (Postfix) with ESMTPS id D19C33F6EB
	for <stable@vger.kernel.org>; Wed,  9 Oct 2024 03:43:13 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=canonical.com;
	s=20210705; t=1728445393;
	bh=Wu6V81u5IdzY9vDfmZ+mK35ruk9Pmu3dx+Stw0yT0ZE=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type;
	b=FMxKVyQXzVbx9PSWm78SL4IsVJNJMBhpY//g8qKMRPMl9S+HJBumjVfG8zWlw6n+k
	 Yy/YRn3XrQxa5qvddpEfjbbR9H/lIivVv4osIM46bYeKNQlszlvta0BrgtCeJqZeU2
	 dRQvPzEa+VIdXl334VOtqz8EUH7EU8ounLzKbZxfc+kvksiJkTVfuIv1f+4MA/8qBt
	 e22VbP0eA7RS5nV1qEMrImRhK7+nMkKb03+UCVBeloTKFmQudPgOn1NYna/01tlE2G
	 FpYf+XGBz+t7hMeMRP0ZGhpam9o9iuBQSJ//QzBIkD8mGMiQ54rrnSJ10tWc6xsiE9
	 4VG5VNeItQVIg==
Received: by mail-qv1-f69.google.com with SMTP id 6a1803df08f44-6cbc7185f75so12701886d6.3
        for <stable@vger.kernel.org>; Tue, 08 Oct 2024 20:43:13 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1728445392; x=1729050192;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=Wu6V81u5IdzY9vDfmZ+mK35ruk9Pmu3dx+Stw0yT0ZE=;
        b=Ff3ubGIhk2QfUDP9TxWK6z+j1TqUL/T0g+XctTgEXTZ7C+Telca1hcv/B6ojh38rbW
         YeGM1WpfQyRxMzIhK/P6HKagWtGsZruqAtbcfyuKeiLheIh/wadeRhxu5oofRTUCKMko
         D23uqk7/IdKg9MMjO2O6euGGT4QE47LkLdr0tzBqnOZfT9Gww39ppuyPB90e8eJs+XI/
         9m7HaOXFI1E/8FwrDu8qpMa8HojLwn/2APpbycK8vuRDTsM/svUFp15Rg3/auSg19dxb
         9ntkd+i6jpNV5UrlqrReT/3aq40whdStyOBmOxS8+FviR8bqN0cfV2wfrGIHNZVXmnDJ
         K0LA==
X-Forwarded-Encrypted: i=1; AJvYcCUWgSgr2f9yeJea7NmDqKg5r6RUQfhvGcAzt/Dc0NSMs45/oVfajMnQDoSmRW51seuLEcDm7ws=@vger.kernel.org
X-Gm-Message-State: AOJu0Yxa+KxOYezGngB0B3HGAQ9VFD34sqiKUkoPtMLOChZ1y4U4PDtp
	LSVDACWH4a+eg9cW8o1ov/EyrjcSXV5zqo8FmfVxmu6Yzrng5cBSa2BkU323u9TKNpnRL2ngu66
	vNprQsV0wxgaM3QqZsUDBKnVRXDtck0e/O7JQObkvrGJi6gJVrrvTUUxZ0E4hGQ+ii+wBNCnE40
	0JRJKVyLORBnh4olJyiD26wk5spO874HE8fhUdrqEsUuETqC6sEdA4
X-Received: by 2002:a05:6214:4a82:b0:6cb:c7ed:a80 with SMTP id 6a1803df08f44-6cbc932f94emr25831416d6.22.1728445392504;
        Tue, 08 Oct 2024 20:43:12 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IEpllvjCcNRqKF4YRbHXU4mgfmm4oEyzxG38LkaCcrfQvdWpTFUsNhVMgo2FvMFDEtTKzEInIptPJ62qPWdi4Y=
X-Received: by 2002:a05:6214:4a82:b0:6cb:c7ed:a80 with SMTP id
 6a1803df08f44-6cbc932f94emr25831236d6.22.1728445392215; Tue, 08 Oct 2024
 20:43:12 -0700 (PDT)
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20241009033716.72852-1-leo.lin@canonical.com>
In-Reply-To: <20241009033716.72852-1-leo.lin@canonical.com>
From: "Yo-Jung (Leo) Lin" <leo.lin@canonical.com>
Date: Wed, 9 Oct 2024 11:43:01 +0800
Message-ID: <CABscksOMvbAbxH-E7V80yJdN8+ePEpDx31idfrdYA+7ZS7MGOg@mail.gmail.com>
Subject: Re: [PATCH] sched: psi: fix bogus pressure spikes from aggregation race
To: leo.lin@canonical.com
Cc: Johannes Weiner <hannes@cmpxchg.org>, Brandon Duffany <brandon@buildbuddy.io>, stable@vger.kernel.org, 
	Chengming Zhou <chengming.zhou@linux.dev>
Content-Type: text/plain; charset="UTF-8"

Hi all,

Sorry for the inconvenience but please ignore this patch. I
accidentally sent this when configuring the email settings. Apologize
for the confusion.

Best,
Leo

