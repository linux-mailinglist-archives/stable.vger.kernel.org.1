Return-Path: <stable+bounces-254695-lists+stable=lfdr.de@vger.kernel.org>
Delivered-To: lists+stable@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id EKYoHKiLF2o5IwgAu9opvQ
	(envelope-from <stable+bounces-254695-lists+stable=lfdr.de@vger.kernel.org>)
	for <lists+stable@lfdr.de>; Thu, 28 May 2026 02:26:16 +0200
X-Original-To: lists+stable@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [172.234.253.10])
	by mail.lfdr.de (Postfix) with ESMTPS id 082005EB393
	for <lists+stable@lfdr.de>; Thu, 28 May 2026 02:26:15 +0200 (CEST)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id 86E7C30B14B9
	for <lists+stable@lfdr.de>; Thu, 28 May 2026 00:25:29 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id E0EC018FC80;
	Thu, 28 May 2026 00:25:28 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="HK8DI4kE"
X-Original-To: stable@vger.kernel.org
Received: from mail-ej1-f53.google.com (mail-ej1-f53.google.com [209.85.218.53])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 52A86175A93
	for <stable@vger.kernel.org>; Thu, 28 May 2026 00:25:27 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=pass smtp.client-ip=209.85.218.53
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1779927928; cv=pass; b=Cv0/6OnX4s1+SGfaScnskhul9pLGLOeDcJfPGr790Ytn499jR0IKLST2krzTQrFYyWSvd607GFeN2M594cl8jOXXVO+0KErUk8F0QkSs7Eu9hTOnB2iUonzH1EOOGZLIBgYyv5Yf/J696zuBeqvUF+qeZCJejgHKgZWArwTrUOY=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1779927928; c=relaxed/simple;
	bh=LhfWtOPN6sxIIjTiJezd5FlbS8EdBOLOmu4HnXcnIHs=;
	h=MIME-Version:From:Date:Message-ID:Subject:To:Cc:Content-Type; b=Ixdvg9f8MLmiN7Qevf0dimtHXFxFygW1uvJcKAi2WhVKYpvcJwry6heF1696LkYHwPeTbwnAIuqWvkUzpdSm7err30DfcpY1mIQ/HnY62XbDbbmRkzXU7Uc0Y3dJB2RMTVhvKfigrNzZw7/5j8pD5+J/T2tQD5db94LoBpJ+jLw=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=HK8DI4kE; arc=pass smtp.client-ip=209.85.218.53
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-ej1-f53.google.com with SMTP id a640c23a62f3a-bd2e8931915so2444551166b.1
        for <stable@vger.kernel.org>; Wed, 27 May 2026 17:25:27 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; t=1779927926; cv=none;
        d=google.com; s=arc-20240605;
        b=VwpI8geMEq0G7rVdIozwCuTD1dI4p6tbtc2RGeoDF2CJFAGCpY5mSF5mLedoZ8GNkd
         HBFzZucj86Pt3wl3XvGujAmPx5NbbxFhyaMnf5H++ahH+N3PT7wZIJnbc+ddN+GyLdyH
         wYoz8qA30QQdWzDg1xYDApNs+nC+b+OXMAdyRPSGwR+7rORUxzgPIBe4j1POyfQMam7K
         degmNXy3PAVIVABw/EC/EXvfMv70QuyXllpkSI6JklabL/9ci9/qdNP4PQbYiGt05Aea
         0+M6P+HMh6Y0IXtcSf/eDaCYY8rj2oS3/lezIk2oq4riZHJHUjUmKUYpRR9EhJuK7CUI
         lOCA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20240605;
        h=cc:to:subject:message-id:date:from:mime-version:dkim-signature;
        bh=26HFoMRc/qTbMxZotH7s2V876fnnoO93+HXZFwGbF0k=;
        fh=Iah/B84/LXq2EGqUPh0mZjSOYsSAK2E1VNAMt273goU=;
        b=JDK7Ptq/osCfuUkPDRSYGME6jJdLThmkG3FQRdDgBxV9wlnC+rLC7VyCqbjgb6kT7f
         Mx0TrWN1b9bEym0OPIQNMBCLj/VXuy4N9AVtou7H2rWT97WRhqDlNiYYh2+aWCXoIKXy
         w48BLcLD7VBLw3PPFMVGXtDzK6KCqERyj6RGMz9GaWnLMZt8zU7r7o2yT9vT8WSRsgwB
         qZv4wWn/TfnBC1mwWUZ+ZxMTu+DAA/cr/9aDAYzctNjdrxdNHHsdYIza2n8ZNr1nPrJU
         +pV10fVntDqPr14hPCVIdmnXWfD5rfPkfH/cevNQxMkzTPCj9Ryh2WmhTvVaRlvmULJO
         63lw==;
        darn=vger.kernel.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1779927926; x=1780532726; darn=vger.kernel.org;
        h=cc:to:subject:message-id:date:from:mime-version:from:to:cc:subject
         :date:message-id:reply-to;
        bh=26HFoMRc/qTbMxZotH7s2V876fnnoO93+HXZFwGbF0k=;
        b=HK8DI4kES+7nj95oPcbIUZTWqxoG1zxyyvsj/OYuZdNgm65uGHZRXSyMdxZAko7w77
         adSoNXZJS0Rp7z/Su4xvju1UGNRrlQabKDsqoFQ76goly06TEeJeavQwuObeqmwTLYPH
         CqV0NujDgBA+jxOTQw6dEA07PZU25hj9xLBX/NVl5vEVCLoLoUjaFnZuVGfnX4CfNIwG
         1x14A9nbR6nxR8qa3kR498v4ZJb3F1lGdLDh0KsBF5c+MiTv781tDgOFXdgKYge+8pXo
         6KRYDJmoTDopFi0yq/Cls2BhODtrLBihS1vdaswANQJQNbfyrHyKrlGggOR58CMfsZ2S
         bEyQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1779927926; x=1780532726;
        h=cc:to:subject:message-id:date:from:mime-version:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=26HFoMRc/qTbMxZotH7s2V876fnnoO93+HXZFwGbF0k=;
        b=AYP/34xtBoAW1+KfbgZqNwCUBsh4z4iHdyzUUBEpKtLT6a/HA6gEZI8phC3UuZwNml
         33G/EKPCojpYf+zMT9PPxIs/HxEiSZhZFyS9x2eejAefz1F7/e+oR+gZvhgzXpYrXjnc
         tC9ks+aB8SedI+5aVCbpZDGyfIZkRGmkCw+tt2pT8zEYxJ5WVrTMIuuIPLooS9ba8vpA
         mAuSCqzGIHApEbo5jAjwMBIVGVhLprEfgHUEIy1EsD4nRN1U64ejuckw26rtHR+mtfrn
         U1spZUaWkTzyCUQcQRVtvuyqvLyq5aI6c1se4fNpTOJf4/m3hcGz6JMfTHtRO1mEAQV0
         VcmQ==
X-Gm-Message-State: AOJu0YyYyojrLGtMBTVLlr//QxEUxm78cbraJ+bTqDxL4r/uh4gliUrI
	Ac3u7bhYlk3KpOz1pbwCGRStWsSVI00TleYgQ2AHd53nwMzjess2cpWQ1YRKsDb4sq8XDj/8LSW
	/7ANZj2fJzLFNX6PcGGIXEkemq3QocsODlw==
X-Gm-Gg: Acq92OFY2W2redNC17cKSmlWJT4XkaZo4IXNFZugojQn4Xc5MmYtXOe+4pC9EiiKmbq
	YsxBtxd2W2xsFxJoR46NNAm5dsuPa1k/RKcDtMe/IuF8PM+bEqi4deaR8YU9XHbkWJUB4RJkUpl
	idZMpsueFgO5vgER2RzlE1GMv1b0ioZ6Jgm4DyUFHQ6WolZFpkE5cmZ3twQdQVukudDZpb8Hfzg
	eTEXvOS5XdZsky2RgANrjEewdDkyW0/8X1PYCSIBXHLyzVWe0+UCbO3FczN50klQidBbthLzZ3o
	az+MKcucXhzx41rKT8UsStFN/wWhk4Uk3S9TQSkGmIkp2sB6ZppgVa1OHFskdI13AyoC/iyFZ4k
	=
X-Received: by 2002:a17:907:7634:b0:b9c:bf69:8b54 with SMTP id
 a640c23a62f3a-bdd4a3bba53mr876925166b.18.1779927925587; Wed, 27 May 2026
 17:25:25 -0700 (PDT)
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
From: Ian Klatzco <iklatzco@gmail.com>
Date: Wed, 27 May 2026 17:25:13 -0700
X-Gm-Features: AVHnY4JijvWf70IPIkNGQDkHiMgcAHanW3QvDMjq11YWGCeJ9jNg6OqjjifZiZM
Message-ID: <CAB=irMzhVj6B=T6XS7VyN9K_5Q+gCHD7dsw7fKSPWuNfjEATvA@mail.gmail.com>
Subject: stable: please backport 3b7a34aebbdf to 6.{6,12,13,14,15}.y ("perf:
 Fix dangling cgroup pointer in cpuctx")
To: stable@vger.kernel.org, yeoreum.yun@arm.com
Cc: gregkh@linuxfoundation.org, sashal@kernel.org, peterz@infradead.org, 
	linux-kernel@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
X-Spamd-Result: default: False [-2.16 / 15.00];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=2];
	DMARC_POLICY_ALLOW(-0.50)[gmail.com,none];
	R_SPF_ALLOW(-0.20)[+ip4:172.234.253.10:c];
	R_DKIM_ALLOW(-0.20)[gmail.com:s=20251104];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	FROM_HAS_DN(0.00)[];
	TAGGED_FROM(0.00)[bounces-254695-lists,stable=lfdr.de];
	RCVD_TLS_LAST(0.00)[];
	RCVD_COUNT_THREE(0.00)[4];
	MIME_TRACE(0.00)[0:+];
	FORGED_SENDER_MAILLIST(0.00)[];
	FREEMAIL_FROM(0.00)[gmail.com];
	DKIM_TRACE(0.00)[gmail.com:+];
	ASN(0.00)[asn:63949, ipnet:172.234.224.0/19, country:SG];
	MISSING_XM_UA(0.00)[];
	TO_DN_NONE(0.00)[];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[iklatzco@gmail.com,stable@vger.kernel.org];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	NEURAL_HAM(-0.00)[-1.000];
	TAGGED_RCPT(0.00)[stable];
	MID_RHS_MATCH_FROMTLD(0.00)[];
	RCPT_COUNT_FIVE(0.00)[6];
	DBL_BLOCKED_OPENRESOLVER(0.00)[sea.lore.kernel.org:rdns,sea.lore.kernel.org:helo,mail.gmail.com:mid]
X-Rspamd-Queue-Id: 082005EB393
X-Rspamd-Action: no action
X-Rspamd-Server: lfdr

Hi all,

linux-6.12.y has the regression commit e9c928807239 ("perf/core: Fix
child_total_time_enabled accounting bug at task exit", backport of
mainline a3c3c6667) but is missing the follow-up fix commit 3b7a34aebbdf
("perf: Fix dangling cgroup pointer in cpuctx", Yeoreum Yun, mainline
v6.16-rc).

The following branches are impacted:

  linux-6.6.y
  linux-6.12.y
  linux-6.13.y
  linux-6.14.y
  linux-6.15.y

The regression silently bypasses perf_cgroup_event_disable() on the
event-removal path when the event is non-ACTIVE at close time, leaving
cpuctx->cgrp dangling at a soon-to-be-freed perf_cgroup struct.  See
3b7a34aebbdf's commit message for the precise description.

The minimum viable patch is as follows:

    @@ in __perf_remove_from_context, after event_sched_out(...):
    +    if (event->state > PERF_EVENT_STATE_OFF)
    +        perf_cgroup_event_disable(event, ctx);
    +

I can prepare per-branch backports if useful; please let me know.

 - Ian Klatzco

