Return-Path: <stable+bounces-206430-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from sin.lore.kernel.org (sin.lore.kernel.org [104.64.211.4])
	by mail.lfdr.de (Postfix) with ESMTPS id 3DFB4D07E17
	for <lists+stable@lfdr.de>; Fri, 09 Jan 2026 09:41:14 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sin.lore.kernel.org (Postfix) with ESMTP id 1A3A8301BEAF
	for <lists+stable@lfdr.de>; Fri,  9 Jan 2026 08:40:37 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 02CD1350D61;
	Fri,  9 Jan 2026 08:40:30 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=suse.com header.i=@suse.com header.b="QT8Fx9DA"
X-Original-To: stable@vger.kernel.org
Received: from mail-lf1-f50.google.com (mail-lf1-f50.google.com [209.85.167.50])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4C2F02EB5CD
	for <stable@vger.kernel.org>; Fri,  9 Jan 2026 08:40:28 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.167.50
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1767948029; cv=none; b=ss34zCtnnIAjnARARJ6PGEBl53VmK/RMvUpcj3imkHdVgnIDa3pJ8BMOojuQ8zoyG7Y29sZL5QMLOGTIPB/Pfw8+VRUICCKDlv/F5U5zjFIkpnUjHqgisbjj57ujzYjBwXdnn18e2pLa7xu+mdCUs9vn7OG9EXAias8CduuU2q4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1767948029; c=relaxed/simple;
	bh=qgQguY/3yJH9vjqUKAYyFPM3gXFuXFaFqMIhKXi9SEE=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=Hry8CHxT32vaSbwQ59NM1ADcPQ3stVggSyaR1VAWzWFXJGYu2Qzm0ytD3YrAGma3lRsTMoVt8vWXGvCP+pcEqBISzMUX1/O1aPNJgGMLQZuNf7xS0ka9Sx2cZxX9r4MrDCdJ1pYursbUcTnYhkEKv9HCUWk4NRKl6w6bgMxyPVc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=suse.com; spf=pass smtp.mailfrom=suse.com; dkim=pass (2048-bit key) header.d=suse.com header.i=@suse.com header.b=QT8Fx9DA; arc=none smtp.client-ip=209.85.167.50
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=suse.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=suse.com
Received: by mail-lf1-f50.google.com with SMTP id 2adb3069b0e04-59b6f59c4f5so3808948e87.3
        for <stable@vger.kernel.org>; Fri, 09 Jan 2026 00:40:28 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=suse.com; s=google; t=1767948026; x=1768552826; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=qgQguY/3yJH9vjqUKAYyFPM3gXFuXFaFqMIhKXi9SEE=;
        b=QT8Fx9DAWvWJmui7LlD1abQGoVPGdLNQoQxUwR9mN9RTUd31zoLXCSK64kSFScumCR
         UVim8gjoVsOPoKQ0W/s1L6l63TPfnZHyf2bXPYSlcVdutfyNbV2zYrh40QANl4u9vtKJ
         Ol9GfbkQbdK/AHshVPcpaT4vqgEcQTOFaMsZKZo5MdfgJZh94uYlLiznoZDJ06SpKmXr
         dOL/ICWqrD0yFutfLLyGq6Nj2wGfqfuRd63UuPFyu4UPECBjAY1fxWbTl7StDCqepFKd
         hYxhNP0LeYcjcK2eHlkB71D195tCOE0ApMdEcia2AF+PlCKAR4K+CY4OfIgB0gbI5Sea
         58gg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1767948026; x=1768552826;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=qgQguY/3yJH9vjqUKAYyFPM3gXFuXFaFqMIhKXi9SEE=;
        b=gr0Wwuyp5pUNeTWXnOhDAJzRGS5eVL+2NoW5B1wVHP5lbjd+K02MIDojUdCXQEE2xc
         46ktEj1dMJHohWW5gEQZIaHI1L8rZ0oMb9FUcAfLizw4xiiSsfrfoYydO6O8Tyk+CEAx
         GHsWw6vuKCmYqiY2MM2771VZZqOU9cbyeBmmui0ZdsUwQnqPZwPVGpDhHrNAii7ay8rk
         AQmz8IciOnkuiuXjaZbcDHHORv3QebutAkML/ivoJ11zYanpAsF6HPZ0wRowSvd7k5Oy
         zjpn+V2y9TA9C5MWfBUpEQ4L+LEg8Esl9uKmx5qPTaK/F1o4gjqOkp2qYw0bwgv/kZV2
         RZOQ==
X-Forwarded-Encrypted: i=1; AJvYcCXMCAL4nGd1lqi9hoSz+k7v7/LxXf+iMzL7deUGfsjrTRpIlD+wQCwvl5kFauMjzASNn1xnRYY=@vger.kernel.org
X-Gm-Message-State: AOJu0YxORB4ZDhFyD9BwBy5xqHeM/88/48WIRzndrF8PCwaIaJk8XkSy
	MEybM1jb3qTywljJl3gAWepFKyZNyAISJj/0G3tXHFzGLLbvGjMNKAcM3mOM+bUaBgs6rX6Gl0d
	bAitFqflvvi2EE9N6CvTAqm0dJ5/WrdlhDiQFt4dgFQ==
X-Gm-Gg: AY/fxX6emRh7wjcwOG3L5cjZKBb+MACYVHNdoCCR71dIKXJaaEmUM0Npk42NFF4EzR8
	JETvrTYQhDmQ7EA7fr49og+pKEZsoJMbQudIpXsrAUJyH0pHy7Pn1f44aNeKTtQDJBsq8kGKpAN
	NGNZy+1DNnYcjsgQsZgYCaZ6D1a27xuozb5YBzRTNvHYF9Yv1Y5PNcqZAjUWHe14zTkqhckO04l
	iLdtUy3Q1wIHkRf3jqZ8X0C7nPF09TRSQtUf1VvKAStA90BF0X8J04mHCeUhzLtfrnHsk6hqABY
	F65oYoPouwm47IbeK0uM0COu1np0
X-Google-Smtp-Source: AGHT+IFXtN+0YseD+T9APEL+SkiwbT/sxspD361H4WQpvC6fXEypZdSjIbUo+lRliv69WpOghJ3hZ0q6u2fo/hSlbqM=
X-Received: by 2002:a05:6512:b90:b0:594:768d:c3ef with SMTP id
 2adb3069b0e04-59b6f036b83mr3136147e87.30.1767948026027; Fri, 09 Jan 2026
 00:40:26 -0800 (PST)
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20260108180148.423062-1-marco.crivellari@suse.com> <aV/5KRqR6zma/ZnR@lstrano-desk.jf.intel.com>
In-Reply-To: <aV/5KRqR6zma/ZnR@lstrano-desk.jf.intel.com>
From: Marco Crivellari <marco.crivellari@suse.com>
Date: Fri, 9 Jan 2026 09:40:15 +0100
X-Gm-Features: AQt7F2q0EjRPIBo-O6epKd7ztDdCOc6wx1_RFqjOb_frYVIgnRnJP8VDXYpdajg
Message-ID: <CAAofZF4F9ZvLMj-=ge2esbvpgoFyyzCdBc2E82inbXry8kKLrA@mail.gmail.com>
Subject: Re: [PATCH] drm/xe: fix WQ_MEM_RECLAIM passed as max_active to alloc_workqueue()
To: Matthew Brost <matthew.brost@intel.com>
Cc: linux-kernel@vger.kernel.org, intel-xe@lists.freedesktop.org, 
	dri-devel@lists.freedesktop.org, Tejun Heo <tj@kernel.org>, 
	Lai Jiangshan <jiangshanlai@gmail.com>, Frederic Weisbecker <frederic@kernel.org>, 
	Sebastian Andrzej Siewior <bigeasy@linutronix.de>, Michal Hocko <mhocko@suse.com>, 
	Thomas Hellstrom <thomas.hellstrom@linux.intel.com>, Rodrigo Vivi <rodrigo.vivi@intel.com>, 
	David Airlie <airlied@gmail.com>, Simona Vetter <simona@ffwll.ch>, stable@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Thu, Jan 8, 2026 at 7:36=E2=80=AFPM Matthew Brost <matthew.brost@intel.c=
om> wrote:
> [...]
> Yikes - thanks for the fix. Will apply our tree shortly.
>
> With that:
> Reviewed-by: Matthew Brost <matthew.brost@intel.com>

Thanks Matthew! :-)

--=20

Marco Crivellari

L3 Support Engineer

