Return-Path: <stable+bounces-241070-lists+stable=lfdr.de@vger.kernel.org>
Delivered-To: lists+stable@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id +CKULZ7x62nWTAAAu9opvQ
	(envelope-from <stable+bounces-241070-lists+stable=lfdr.de@vger.kernel.org>)
	for <lists+stable@lfdr.de>; Sat, 25 Apr 2026 00:41:34 +0200
X-Original-To: lists+stable@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [172.234.253.10])
	by mail.lfdr.de (Postfix) with ESMTPS id 19CC9463D89
	for <lists+stable@lfdr.de>; Sat, 25 Apr 2026 00:41:34 +0200 (CEST)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id 1D7DE30137B0
	for <lists+stable@lfdr.de>; Fri, 24 Apr 2026 22:40:13 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 296483FE656;
	Fri, 24 Apr 2026 22:40:12 +0000 (UTC)
X-Original-To: stable@vger.kernel.org
Received: from mail-wr1-f49.google.com (mail-wr1-f49.google.com [209.85.221.49])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id DBF2A34404E
	for <stable@vger.kernel.org>; Fri, 24 Apr 2026 22:40:02 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.221.49
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1777070411; cv=none; b=O9gR9X9uaIektB9HI1Y6pNkKmeiMGGW69kvmm72Gn/wwdG8wmg6XC1SWuZyxiM/Tgeh1eZG8A86Y/lSOP9nuEz+b3KwJMTb9kM8vo1HU6fGK6oW+tbvuGEPof8vKzcgBF6Nld5+NU4J1YPcAHKgz7xSXsBWQJa/tgxL4R9pY2Uk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1777070411; c=relaxed/simple;
	bh=nWpDQmZNg8zKVk12QskQ7NNS05C4fI/JmZBKLdKyu8Q=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=scp9Vi2bTLO7rYWv7N+PGmdzCSZeGe/VcxPpU2VgCfgZ4Ssb+PnwnQcDm49NpGUYngXybsyMzg7V08QJowMj2ajeS6T3+Xn0OLb5mOaezFwWO46sdBC9tqsReUGvE+omGf5uxO0BiQgbzgdb5eU0LSxnN7ypp2nie5fkAOGdAcA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=grimberg.me; spf=pass smtp.mailfrom=gmail.com; arc=none smtp.client-ip=209.85.221.49
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=grimberg.me
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-wr1-f49.google.com with SMTP id ffacd0b85a97d-43d77f60944so6390915f8f.3
        for <stable@vger.kernel.org>; Fri, 24 Apr 2026 15:40:02 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1777070401; x=1777675201;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :x-gm-gg:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=nWpDQmZNg8zKVk12QskQ7NNS05C4fI/JmZBKLdKyu8Q=;
        b=X9IaLHKsFHma0aUJ1ULdaQCtBKcsIsRqHp/h/m4kvZ4P1JSwJHtmeqSF816EpHYPly
         3fLJThVEYYPt1wGHzN0U98oh3BmcFolTSIQ4O1zGGhIuZDx4AX9hAJZ7B5o2PIW98rcy
         0rNwmS3sleP+e23ArBr5szDsqYuSO0v9QFDnNfuOheBcX+WsSC+4tQJA0MHMiKYxKkzL
         fwvUxcPhMV/LDwUVINSpT5vfpXwuY+lShJm+jYBT3YBJjIQ2ReU0eD2cpnfNOgCIb1Bj
         pey97GNl0Zs/71MWaCFO2Sdtt8CYeImdKEOZriGqywCsDT0brnexQr9QmL9yLdO0+LRH
         UJ1w==
X-Gm-Message-State: AOJu0YxKqSC9iKkjaOIQrM8cT3JjSv8OTcvSIr6GdkMyKjC2Wm/j6Twl
	VR0IPqnfuPebI3+D+wx3sjOzcFrN+uYOaF+JXJmkhxYWqoWqS/gCK+zI
X-Gm-Gg: AeBDiesa5n1xpUmfo6uj0kDuVTEhueIIjKyNI+0a589HQXLvy6W/JGle6cMEmKasdPW
	XXSQDvAxJQO1ZbkYlWhZM6dU4pbGSOZ1G6Ka6Rh8l9Ta4mKpvU0+sOhv2CkBuLZahsmXrvV2Qjg
	ERSr7ddcFjFd2d3ASmAVxSyNRW3PDBqCZW7RB4J9Tb4beWmOWuRMfc1iKuiX1doAWMGZAm7abgY
	6pG8Jo8IzoloCvjFxJulodTLk62zk/CaCn/k74zztgW9riT/AqNbuyyOouftHGPSdPm1GgNiazM
	0v7osfMA/E1HOwZG4gFQSHhAAfi5YOVycRFFPqyKSAsV71EK4BAAoM4UIJtWy99jVNGUKGqZ4Xr
	wwFFQhze/t824vrY5l1dJx/dGTDkflFJAV7Bg+QbBkHCgMQCmZHlVZI6vIQLwpf4OmhQ0E1EUlA
	DqWmrFhmQq6u60q+6BJT+oIUKBHuVDjSlZEWqfOQ7A213OmSQPWIZpc1lJE/tJrosCMlA0
X-Received: by 2002:a05:6000:240e:b0:43d:714:34e5 with SMTP id ffacd0b85a97d-43fe3e0d2e3mr52061125f8f.24.1777070400837;
        Fri, 24 Apr 2026 15:40:00 -0700 (PDT)
Received: from [10.100.102.74] (89-138-71-216.bb.netvision.net.il. [89.138.71.216])
        by smtp.gmail.com with ESMTPSA id ffacd0b85a97d-43fe4c221cdsm64106244f8f.0.2026.04.24.15.39.59
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Fri, 24 Apr 2026 15:40:00 -0700 (PDT)
Message-ID: <9ae09c33-dbee-4eab-a238-9c78e6416ab4@grimberg.me>
Date: Sat, 25 Apr 2026 01:39:59 +0300
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH 1/3] nvme-auth: Don't log shared secret in
 nvme_auth_dhchap_exponential()
To: Thorsten Blum <thorsten.blum@linux.dev>, Hannes Reinecke <hare@suse.de>,
 Keith Busch <kbusch@kernel.org>, Jens Axboe <axboe@kernel.dk>,
 Christoph Hellwig <hch@lst.de>
Cc: stable@vger.kernel.org, linux-nvme@lists.infradead.org,
 linux-kernel@vger.kernel.org
References: <20260303190350.78705-2-thorsten.blum@linux.dev>
Content-Language: en-US
From: Sagi Grimberg <sagi@grimberg.me>
In-Reply-To: <20260303190350.78705-2-thorsten.blum@linux.dev>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-Rspamd-Queue-Id: 19CC9463D89
X-Rspamd-Action: no action
X-Rspamd-Server: lfdr
X-Spamd-Result: default: False [-1.46 / 15.00];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	R_SPF_ALLOW(-0.20)[+ip4:172.234.253.10:c];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	MIME_TRACE(0.00)[0:+];
	DMARC_NA(0.00)[grimberg.me];
	ASN(0.00)[asn:63949, ipnet:172.234.224.0/19, country:SG];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	TAGGED_FROM(0.00)[bounces-241070-lists,stable=lfdr.de];
	RCVD_TLS_LAST(0.00)[];
	FORGED_SENDER_MAILLIST(0.00)[];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	FROM_HAS_DN(0.00)[];
	SINGLE_SHORT_PART(0.00)[];
	TAGGED_RCPT(0.00)[stable];
	RCVD_COUNT_FIVE(0.00)[5];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[sagi@grimberg.me,stable@vger.kernel.org];
	TO_DN_SOME(0.00)[];
	NEURAL_HAM(-0.00)[-1.000];
	RCPT_COUNT_SEVEN(0.00)[8];
	R_DKIM_NA(0.00)[];
	MID_RHS_MATCH_FROM(0.00)[];
	DBL_BLOCKED_OPENRESOLVER(0.00)[sea.lore.kernel.org:helo,sea.lore.kernel.org:rdns]

Reviewed-by: Sagi Grimberg <sagi@grimberg.me>

