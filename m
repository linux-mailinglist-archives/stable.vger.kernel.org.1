Return-Path: <stable+bounces-254454-lists+stable=lfdr.de@vger.kernel.org>
Delivered-To: lists+stable@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id wYnXNAgrFmqdigcAu9opvQ
	(envelope-from <stable+bounces-254454-lists+stable=lfdr.de@vger.kernel.org>)
	for <lists+stable@lfdr.de>; Wed, 27 May 2026 01:21:44 +0200
X-Original-To: lists+stable@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [172.234.253.10])
	by mail.lfdr.de (Postfix) with ESMTPS id 387B25DD7D3
	for <lists+stable@lfdr.de>; Wed, 27 May 2026 01:21:43 +0200 (CEST)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id 3D637304095F
	for <lists+stable@lfdr.de>; Tue, 26 May 2026 23:21:41 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 80F983C0628;
	Tue, 26 May 2026 23:21:39 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="CA6SU0Dh"
X-Original-To: stable@vger.kernel.org
Received: from mail-qt1-f174.google.com (mail-qt1-f174.google.com [209.85.160.174])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E776429E117
	for <stable@vger.kernel.org>; Tue, 26 May 2026 23:21:37 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.160.174
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1779837699; cv=none; b=gbAa92rgSFhl0sLfzFSLbR72q+VAxYVdvEyZrhyNPaluyKTODt6dmKmYvBcdD/ZF4WhfWXIdo975O93gw4dkclA6+UqZ6PxKtFKgoy7tp+Ml3n9oFX37vAr/ma1pygoTZxK6WREE0kb+ICiZSTx4EoPTlisWI2eV7XL4ivHpC78=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1779837699; c=relaxed/simple;
	bh=GNseIYPxJ3cmW+l193MU1A8d8rdG4X/eR9u+Vb0r/Ug=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=Y8Wos69VsxdKT+XuGd3WBrJovVxTrlBmDVlZ9INhIDhHfNdKBbacOK05lAZ/VFZlTqSTbFnHaRZwB0graiXngjt+Qfh1OuVd0RGB5QASJ4n8Jw0nLJUi/b+GkeZ8nKn3WkF3oH+uv4iNI7hyYs8d/oAo6CVgNI2PsaLDuNm/qyg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=CA6SU0Dh; arc=none smtp.client-ip=209.85.160.174
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-qt1-f174.google.com with SMTP id d75a77b69052e-516d083c98cso4684971cf.1
        for <stable@vger.kernel.org>; Tue, 26 May 2026 16:21:37 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1779837697; x=1780442497; darn=vger.kernel.org;
        h=in-reply-to:content-transfer-encoding:content-disposition
         :mime-version:references:message-id:subject:cc:to:from:date:from:to
         :cc:subject:date:message-id:reply-to;
        bh=BiZFVTxQnyNG17gARCnVzZAOXJ6pRd4xFKXb5aZrpTw=;
        b=CA6SU0DhAMu3GVEm8IlcqZBY1g7hA2LWfQ8g4PhFG0Z+5Cr6HbL3XifQf/ainqcyXN
         roAVh/Gggrqdw0OUIauVs4TQeEguxhIaGeMobjyZKvOSI10xJf0qXE0Gf6ux6ZD7O1Pl
         ri83EYOueu6XzaNVjhbWPxcHn6+Rgch6KeUjyQ2zpTKwpZ20HnKtljW4iSEdFSLlN5JR
         IzQ8w+UReW3SumzxBgNsWKzvPOUwuEqqjFGo83J1opHkj9LoN4pIySHvrhGYH1YDiaSY
         ffOgOfThi2Zk1jcFtH6h1EZ9SbVSN+XyjMX25wm8xAKWYwK0Q+x532/xbhHPPQRiVewP
         yRBw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1779837697; x=1780442497;
        h=in-reply-to:content-transfer-encoding:content-disposition
         :mime-version:references:message-id:subject:cc:to:from:date:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=BiZFVTxQnyNG17gARCnVzZAOXJ6pRd4xFKXb5aZrpTw=;
        b=N/hiS8ASIbVxxAcurEcedpsoHtFkNxwXBJimt3cc+8lVKjgb0Re3+7Wbmw9RjI5ane
         WOWlvgrtkzHdDPvvG5BdEwYHMwSrTgyB5p7RuB4a8CfWKNOUSBF2sfC+U1K6/a1MifMM
         vIp63llSskhyRGr/ow/LTwOAcfbIOlUppE10JS1nivmxrJLttbwLpV7UWS5MQm6TfFWm
         gu8J0BBMnutK4PSp0Xh5QIOktY6+eSU5Jwb50QVMxyQ7D85t1RhlfSgsFDZh2iHxL7ds
         Qq8GmEpQUpVvOEe8ojV8esJY+AHSbnt4y5Nxh4Efs9eaM4uq7iPIrCl2gnlLyN8Sz4Yr
         41qg==
X-Forwarded-Encrypted: i=1; AFNElJ+k6HMCwcOmknVc0JG3QWqWSWx7i60HinOMN74cEIcuT/REELltNK8bbun5nnFfzK4mduztLgA=@vger.kernel.org
X-Gm-Message-State: AOJu0Yxha7hl0vVYGOrU7Ve0g5x8C29TB+kyjxAq6yQirWBErnN0XYS5
	3fMvh+XIKpoun61m7tCZ5nZL20OEGjMWCZvi0hrm0MW2v0F+DEkOyeNb
X-Gm-Gg: Acq92OHkb+oHFHhsUC1epBXkKGdRDUHiLQjWiZ5o3dx4UtIde/eZZfjfT2RccULGVaD
	ph083yb9Q94u4u1CE6TeOlpTWPaSLUPmfyx3dtuLVY0igVsuFzMp0fO1YIScKJfGj7JgN/YNkYT
	n3uIgg/O28QL1Y+v30ovhkb+rPwHEEq8fN0rmjqciRubTvxHxbzvCYU9vFPuGf0Mb/CWgiqBawr
	vNRiKme1tpZKLWFqJjKT9P5XzYJwwtOyItlVEGq2xcSvS5ydettG+6knVDkIo6t9MpRyht8xso1
	Mne9Z00jhwFOZkg7TpW8H02ogX95Nfb0hJZFNIA0k0mPaKITzCZuC+svCMKY5SiNpnZPvx1cw1V
	Ps5+AAm1ghVlWaqJKBV0v6ZUe9Pb8eD7VZSb3oIIu1CavRGCUNszrIVUnLAXGQGuRhBUML+l8NG
	gAc58Tv3hLb4pM9G8fNRekIWmw2rVg7AVRU+fSfaJxHP/fUYMvqlbAIruyrPsHU5Q+6bTo0ec=
X-Received: by 2002:a0c:e091:0:b0:8ac:a205:f118 with SMTP id 6a1803df08f44-8cc7b5e585bmr199693176d6.8.1779837696675;
        Tue, 26 May 2026 16:21:36 -0700 (PDT)
Received: from luigi.stachecki.net ([96.224.31.104])
        by smtp.gmail.com with ESMTPSA id 6a1803df08f44-8cc8132f780sm154586406d6.49.2026.05.26.16.21.35
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 26 May 2026 16:21:35 -0700 (PDT)
Date: Tue, 26 May 2026 19:21:33 -0400
From: Tyler Stachecki <stachecki.tyler@gmail.com>
To: Salvatore Bonaccorso <carnil@debian.org>
Cc: Greg Kroah-Hartman <gregkh@linuxfoundation.org>, stable@vger.kernel.org,
	patches@lists.linux.dev, Ian Rogers <irogers@google.com>,
	Namhyung Kim <namhyung@kernel.org>, Sasha Levin <sashal@kernel.org>,
	regressions@lists.linux.dev
Subject: Re: [PATCH 6.12 375/666] perf tool_pmu: Factor tool events into
 their own PMU
Message-ID: <ahYq/YrKZ+PjCh2W@luigi.stachecki.net>
References: <20260520162111.222830634@linuxfoundation.org>
 <20260520162119.375577583@linuxfoundation.org>
 <ahMPWN_PZlQLisk4@eldamar.lan>
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <ahMPWN_PZlQLisk4@eldamar.lan>
X-Spamd-Result: default: False [-2.16 / 15.00];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	DMARC_POLICY_ALLOW(-0.50)[gmail.com,none];
	R_SPF_ALLOW(-0.20)[+ip4:172.234.253.10];
	R_DKIM_ALLOW(-0.20)[gmail.com:s=20251104];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	MIME_TRACE(0.00)[0:+];
	DKIM_TRACE(0.00)[gmail.com:+];
	FORGED_SENDER_MAILLIST(0.00)[];
	RCVD_TLS_LAST(0.00)[];
	TAGGED_FROM(0.00)[bounces-254454-lists,stable=lfdr.de];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	MISSING_XM_UA(0.00)[];
	FROM_HAS_DN(0.00)[];
	TO_DN_SOME(0.00)[];
	RCVD_COUNT_FIVE(0.00)[5];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[stacheckityler@gmail.com,stable@vger.kernel.org];
	ASN(0.00)[asn:63949, ipnet:172.234.224.0/19, country:SG];
	NEURAL_HAM(-0.00)[-1.000];
	TAGGED_RCPT(0.00)[stable];
	RCPT_COUNT_SEVEN(0.00)[8];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	FREEMAIL_FROM(0.00)[gmail.com]
X-Rspamd-Queue-Id: 387B25DD7D3
X-Rspamd-Action: no action
X-Rspamd-Server: lfdr

On Sun, May 24, 2026 at 04:46:48PM +0200, Salvatore Bonaccorso wrote:
> hi Greg, 
> On Wed, May 20, 2026 at 06:19:46PM +0200, Greg Kroah-Hartman wrote:
> > 6.12-stable review patch.  If anyone has any objections, please let me know.
> > 
> > ------------------
> > 
> > From: Ian Rogers <irogers@google.com>
> > 
> > [ Upstream commit 240505b2d0adcdc8fd018117e88dc27b09734735 ]
> > 
> > Rather than treat tool events as a special kind of event, create a
> > tool only PMU where the events/aliases match the existing
> > duration_time, user_time and system_time events. Remove special
> > parsing and printing support for the tool events, but add function
> > calls for when PMU functions are called on a tool_pmu.
> > 
> > Move the tool PMU code in evsel into tool_pmu.c to better encapsulate
> > the tool event behavior in that file.
> 
> While building now a complete set of packages for Debian for 6.12.91
> where perf tools are included as well, I noticed that now the builds
> fails. In fact in v6.12.91 
> 
> $ cd tools
> $ LC_ALL=C.UTF-8 ARCH=x86 make perf
> 
> fails with:
> 
> [...]
>   CC      util/stat.o
> util/tool_pmu.c: In function ‘tool_pmu__config_term’:
> util/tool_pmu.c:62:49: error: implicit declaration of function ‘parse_events__term_type_str’; did you mean ‘parse_events_term__str’? [-Wimplicit-function-declaration]
>    62 |                                                 parse_events__term_type_str(term->type_term),
>       |                                                 ^~~~~~~~~~~~~~~~~~~~~~~~~~~
>       |                                                 parse_events_term__str
> util/tool_pmu.c:61:79: error: format ‘%s’ expects argument of type ‘char *’, but argument 3 has type ‘int’ [-Werror=format=]
>    61 |                                                 "unexpected tool event term (%s) %s",
>       |                                                                              ~^
>       |                                                                               |
>       |                                                                               char *
>       |                                                                              %d
>    62 |                                                 parse_events__term_type_str(term->type_term),
>       |                                                 ~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~
>       |                                                 |
>       |                                                 int
> cc1: all warnings being treated as errors
>   CC      util/stat-shadow.o
>   LD      util/hisi-ptt-decoder/perf-util-in.o
>   CC      util/stat-display.o
> make[5]: *** [/home/build/linux-stable-rc/tools/build/Makefile.build:105: util/tool_pmu.o] Error 1
> make[5]: *** Waiting for unfinished jobs....
>   CC      util/perf_api_probe.o
>   LD      util/perf-regs-arch/perf-util-in.o
> util/cgroup.c: In function ‘evlist__expand_cgroup’:
> util/cgroup.c:498:32: error: ‘struct evsel’ has no member named ‘first_wildcard_match’
>   498 |                         if (pos->first_wildcard_match)
>       |                                ^~
> util/cgroup.c:499:38: error: ‘struct evsel’ has no member named ‘first_wildcard_match’
>   499 |                                 evsel->first_wildcard_match = pos->first_wildcard_match->priv;
>       |                                      ^~
> util/cgroup.c:499:66: error: ‘struct evsel’ has no member named ‘first_wildcard_match’
>   499 |                                 evsel->first_wildcard_match = pos->first_wildcard_match->priv;
>       |                                                                  ^~
> make[5]: *** [/home/build/linux-stable-rc/tools/build/Makefile.build:105: util/cgroup.o] Error 1
>   LD      util/arm-spe-decoder/perf-util-in.o
>   LD      ui/browsers/perf-ui-in.o
>   LD      tests/workloads/perf-test-in.o
>   LD      ui/perf-ui-in.o
>   LD      perf-ui-in.o
>   AR      libperf-ui.a
>   LD      tests/perf-test-in.o
>   LD      perf-test-in.o
>   AR      libperf-test.a
>   LD      util/scripting-engines/perf-util-in.o
>   LD      util/intel-pt-decoder/perf-util-in.o
>   LD      perf-in.o
> make[4]: *** [/home/build/linux-stable-rc/tools/build/Makefile.build:162: util] Error 2
> make[3]: *** [Makefile.perf:789: perf-util-in.o] Error 2
> make[3]: *** Waiting for unfinished jobs....
>   CC      pmu-events/pmu-events.o
>   LD      pmu-events/pmu-events-in.o
> make[2]: *** [Makefile.perf:292: sub-make] Error 2
> make[1]: *** [Makefile:76: all] Error 2
> make: *** [Makefile:93: perf] Error 2
> 
> Regards,
> Salvatore

Second this - moreover, because of the other commits introduced in tools/perf
as of 6.12.91, it's not possible to revert just this one commit without other
conflicts.

Cheers,
Tyler

