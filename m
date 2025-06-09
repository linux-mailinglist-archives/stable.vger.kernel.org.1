Return-Path: <stable+bounces-152004-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 59C27AD19F1
	for <lists+stable@lfdr.de>; Mon,  9 Jun 2025 10:43:53 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 4B7223A8B53
	for <lists+stable@lfdr.de>; Mon,  9 Jun 2025 08:43:30 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 5495320E00C;
	Mon,  9 Jun 2025 08:43:48 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="NLfNS785"
X-Original-To: stable@vger.kernel.org
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.133.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5CB5F1386B4
	for <stable@vger.kernel.org>; Mon,  9 Jun 2025 08:43:46 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.133.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1749458628; cv=none; b=fvBsl6g8cX+/ZZ+jYYe4A9NkaM7CrtvZ88MBjMz5NXe2HKhgUTmd8d2Ze0E2rck7JJIwKRmulvreVmbK3NAA8Ig+gySX98J5bZfu+EMnnPmv1JzL2W2rseZ6e0xgoDtkId4zD7wHoSmZbTrOVWbvJfvet5JQvHmzavg1e9mym/I=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1749458628; c=relaxed/simple;
	bh=nIcAKbPXJzCwsjj9UXX4OkVGsb+EilgDyTj//tcBE7s=;
	h=MIME-Version:From:Date:Message-ID:Subject:To:Cc:Content-Type; b=LYkSDndtJAoNaHKtgkqKeqVaA2o8n4v25edOFaU5aw0yfbK2kAWzDCxOj2Rgy1rEtYQEHRfwnPgJo02vixNViTnG5CBWCuzKF0iAasDal3XEuBpLCg7+fab16+5W5X+ugckZKaYsNcr/YBFoESSeAyOouJtTB3odI/AfdS3Xqmk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=NLfNS785; arc=none smtp.client-ip=170.10.133.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1749458625;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type;
	bh=nIcAKbPXJzCwsjj9UXX4OkVGsb+EilgDyTj//tcBE7s=;
	b=NLfNS785JxVPjPBeoDn3VKU4+6oBsAtbjcNpHKrH10eW1oAGPGcQjCTeAg/JPfI40ycDh3
	HljvlA542YJ0k9NLkMfo8flfrY5yZKQ389OZcFQ+eK28sx1837aqCcTBX4MGqAZmsYT15z
	qCsyi0Plu0NYBH2buvnCsedhJJWO/wE=
Received: from mail-ej1-f72.google.com (mail-ej1-f72.google.com
 [209.85.218.72]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-120-D-ZXo0X5N4yRX3J8h0s2ag-1; Mon, 09 Jun 2025 04:43:44 -0400
X-MC-Unique: D-ZXo0X5N4yRX3J8h0s2ag-1
X-Mimecast-MFC-AGG-ID: D-ZXo0X5N4yRX3J8h0s2ag_1749458623
Received: by mail-ej1-f72.google.com with SMTP id a640c23a62f3a-adb599005aeso253441666b.1
        for <stable@vger.kernel.org>; Mon, 09 Jun 2025 01:43:43 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1749458623; x=1750063423;
        h=cc:to:subject:message-id:date:from:mime-version:x-gm-message-state
         :from:to:cc:subject:date:message-id:reply-to;
        bh=nIcAKbPXJzCwsjj9UXX4OkVGsb+EilgDyTj//tcBE7s=;
        b=oji2h3vei9TR46zFOxSwK70yJ/A/DWbuFqHFoc5F6yfw0gM4qVn9i9jfWHeEYC7ADQ
         iuotBju3IdW9BwpzJOZKO7P+1x8jSdPlmzC/2Pgxp+chiYQZxmcnHKSXcUy2WllZKa5s
         LU2E/EJWCi/WygwKBWtrZ+mAPFCpve8XOJBkTxjeFCg/fHQc0+aZllaMcNu/wa/M9YyF
         ytUUjhCoyC+1P0rPb3B1UrwfDqRoP0fJgS21SZhnqEBI8EAYQbep6du+OJ2I+q1br1Mk
         90o8Vv8aP+PcHUcBZztbh+1UxFkSyPid3y9QILhanRAcgGn2HBJCxxwmuQV1eKOsaPC+
         66Ng==
X-Gm-Message-State: AOJu0YxxOSjZVrn8JXheOrWvZBZI+PmKTLuD3ZYppvwRdtSgPnHUydLT
	ZtPgNM0XQ4xx3SOH2/nd+wQtoM2ppWU9SA6m/oNn1CeoM3XeZXTkHCVBbjm+B66x6vtIsFOr9+N
	xNk16DRcjf/diOgKuUG9GqpVV8/pM1p0zrb3cIAlDhbTvMLNLIgFNBtZQijzzyljjR/NwhmdeEG
	XYBcpNRwwyezohDnT9937MsJmdB5FzZ23l2r88kYxHumk=
X-Gm-Gg: ASbGncv4N1fbDH2HZcFkVdARN3RBjGozkg5VQ8e7qVe0FrRdbThAKW9CNRRjGdRk5Lv
	60YhA/zXgER+GRA7rVUphPQY6TZpUhJyeaYyXCGAnDRD7Qu6rp2tfQlCApFFDAMi6z/+72Kyma0
	qhFylR2ax/WQZEp5zICfBrWGo=
X-Received: by 2002:a17:907:6d28:b0:ad8:8529:4fa5 with SMTP id a640c23a62f3a-ade1aab9f63mr1182341566b.46.1749458622662;
        Mon, 09 Jun 2025 01:43:42 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IGFsTBRCoF1ju5/WVdTWoW7a8nhVDZdX7YxxA2xYfGxoGqr0RROFvfHo3j554ir/0sIuGD/tDVpQWJt+hlBvIQ=
X-Received: by 2002:a17:907:6d28:b0:ad8:8529:4fa5 with SMTP id
 a640c23a62f3a-ade1aab9f63mr1182340266b.46.1749458622220; Mon, 09 Jun 2025
 01:43:42 -0700 (PDT)
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
From: Tomas Glozar <tglozar@redhat.com>
Date: Mon, 9 Jun 2025 10:43:30 +0200
X-Gm-Features: AX0GCFsqvCcGu-vJJZID5UPplam393fev10AGj6IwSGWjLOqoVoC6StR-3dlT58
Message-ID: <CAP4=nvS5FycSj7G8U5Tk971S-iAV=_hJP6YPnDwOJGu_T7ofiA@mail.gmail.com>
Subject: Request for backporting rtla fix into 6.15-stable
To: stable@vger.kernel.org
Cc: Steven Rostedt <rostedt@goodmis.org>
Content-Type: text/plain; charset="UTF-8"

Hello,

Please pull the following upstream patch to 6.15-stable:

8020361d51ee "rtla: Define _GNU_SOURCE in timerlat_bpf.c"

This fixes an rtla bug that was introduced in 6.15 and was expected to
be merged into 6.15, hence it was not tagged with Cc: stable, but did
not make it.

Thanks,
Tomas


