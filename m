Return-Path: <stable+bounces-254033-lists+stable=lfdr.de@vger.kernel.org>
Delivered-To: lists+stable@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id Lq00IbcPE2r97AYAu9opvQ
	(envelope-from <stable+bounces-254033-lists+stable=lfdr.de@vger.kernel.org>)
	for <lists+stable@lfdr.de>; Sun, 24 May 2026 16:48:23 +0200
X-Original-To: lists+stable@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [172.234.253.10])
	by mail.lfdr.de (Postfix) with ESMTPS id 413055C2BB2
	for <lists+stable@lfdr.de>; Sun, 24 May 2026 16:48:17 +0200 (CEST)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id 3BC053004F74
	for <lists+stable@lfdr.de>; Sun, 24 May 2026 14:46:54 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id A72C4392C47;
	Sun, 24 May 2026 14:46:53 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="kB0qAF7a"
X-Original-To: stable@vger.kernel.org
Received: from mail-wm1-f46.google.com (mail-wm1-f46.google.com [209.85.128.46])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id F013925B085
	for <stable@vger.kernel.org>; Sun, 24 May 2026 14:46:51 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.46
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1779634013; cv=none; b=nrJTx0QQ38jJQSN7YJ05idkKxdFNzBbFdWbc7E+hwOT+eoYXnDkFNNAI8a/+JZjijUMx6aLplfioQExBMi4ao5FJ2QFMc6JyvmMEz/XeBlFkR4zrA49d3zog28d90X9M3xXIIOKN2f5DYXA+/x9o+xSvOzX1bc3LOaQXyE21Adc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1779634013; c=relaxed/simple;
	bh=JEZWG6SWAXC3kSsKtJeswOT8sOerhSc4wffC3XsQE5A=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=TqIfKoW2scVBU1HIgekgb1/sanV+q6fjF9DOZiS8MrDgi1BVq7aWdRw71FDlzF5RyaYvKqD5ofm6KUB3rTPFIcPODcCWCK9ayzZcdoY5mIzSVctlmA+z3YLAFgvH8tTRiD6VVQSGzGWt+Nx/iAo0lCENXnvJGs0dSizWy3Dm2ac=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=fail (p=none dis=none) header.from=debian.org; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=kB0qAF7a; arc=none smtp.client-ip=209.85.128.46
Authentication-Results: smtp.subspace.kernel.org; dmarc=fail (p=none dis=none) header.from=debian.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-wm1-f46.google.com with SMTP id 5b1f17b1804b1-49042aeeb75so33089925e9.1
        for <stable@vger.kernel.org>; Sun, 24 May 2026 07:46:51 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1779634010; x=1780238810; darn=vger.kernel.org;
        h=in-reply-to:content-transfer-encoding:content-disposition
         :mime-version:references:message-id:subject:cc:to:from:date:sender
         :from:to:cc:subject:date:message-id:reply-to;
        bh=A6knduYAQaCV7hHxlTFEjJDyN7v2hRFonwrpL8674II=;
        b=kB0qAF7axZwhj9CA68cqEgUx0YcmR3XoXg0AhARpvtLSn0BaGfHizkUWIRveYUI5lE
         uM5LWjc911aUQm1nfdkcTiQembC5EgaHoZGhzEKikGc7CuQV01ryQSgmi/24Fw2p3N7E
         5RcGrwjtaIL2KV1Dfka92EK5V1sKtng2fpiFTl3DuwntZNuBxP0hLNVuX6NMMjEpx8lp
         rc5y++0oTApCMJM2dtcsOPB1RH30EuLQ9hsE+AJkaHiFySG5wT4kxrpKPoYibdgTErUW
         qdz/pNQN2TkHpplbHDHeAE53uiA+kwHHhj//9EY4UW2ca6Og9vWrJ//0FpLJOwbHKgd5
         bMQg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1779634010; x=1780238810;
        h=in-reply-to:content-transfer-encoding:content-disposition
         :mime-version:references:message-id:subject:cc:to:from:date:sender
         :x-gm-gg:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=A6knduYAQaCV7hHxlTFEjJDyN7v2hRFonwrpL8674II=;
        b=soYzQDKxwVjxGpbdM3LMeOFi5+P9v/ODdD7NiddfQN0OI67R1CHPsdqpDsUVTCZ0gh
         D9OagtfEzBVveNlDOYwUx3UDldJIRW1e2wB5WtTA6OyOp7wckkFfjo7b06tP5KFEmvYp
         u6tW0i7dCvBhQZ/GXlEn19mvBLwdEHHUg2UEcRN+2CuqekK9TXfcGmxKrWP5zhy7n8NZ
         AdApiVmwC3GcjND7KTXiMiysrhqAQzg47H3y26I8gBzZNApqouE1j3hlJq/WFi6Zds4V
         299C0MKL0yHSo071rlNRTw65RjMyUpNrvUkC1YeekhvNB3ue1KeR7yDXN1Rp6Wj7vhbr
         /uzw==
X-Gm-Message-State: AOJu0YxgOZT9DtC42SmnXrNAdQShQYbO8Oc/ElYwlaoAQuQyus/PvhyP
	gqzcCfWmeUpC0RI5/tdaAKKUIKi0LTsLrJv1whi5R+LfA0xA1k88ma9F
X-Gm-Gg: Acq92OEjzpafc5ekKb2qv3pxdEES8Cs/z6ws3ZshJDA4Yeh/GG3VaAZJTenR7H2hXDK
	A+Wjxd6HZ4l04QGivHmI477R8J8gCA9Eivr3qb5t3y6mMCrlH2oCTn/1tTd+rgA2Y9zCt//IFj4
	84Zxpme7bMn9YGERgJ+H4J0WHHI7WMX7eNAFWU51xN9nEsBy36e7/CTRdxk5qwXh/3Em6uTbi8K
	FSD57g6S7GFiaT1EMMeR4cWQH8V6twFcHpTB47ZJHIR1qnGRNM6A1o772W6dyI9ydS63v+GVl4f
	DvJ8KDGY9JPTiyZ3XbIw5oAM+it6b0gQxpuDeXgXuvTY1JnRQFwZd/cPycll1kdZqzDloPdxD0U
	NE2m+3Yiku5Kl5PRyk0eIKSGulHlWocZ5pMrfXRVU7AqGRRcktmU69BXW7Qr3I6ibKGYtbts1OA
	3vofxpXTNkLuCz4VBsljyzDhcJTurn5DWcSwzKmKIAOeUiDahRdkHLLMe4lNI=
X-Received: by 2002:a05:600d:6450:10b0:48a:7a10:4f17 with SMTP id 5b1f17b1804b1-4904249d125mr126693985e9.6.1779634010232;
        Sun, 24 May 2026 07:46:50 -0700 (PDT)
Received: from eldamar.lan (c-82-192-247-196.customer.ggaweb.ch. [82.192.247.196])
        by smtp.gmail.com with ESMTPSA id 5b1f17b1804b1-490454cfcaesm177192395e9.4.2026.05.24.07.46.49
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sun, 24 May 2026 07:46:49 -0700 (PDT)
Sender: Salvatore Bonaccorso <salvatore.bonaccorso@gmail.com>
Received: by eldamar.lan (Postfix, from userid 1000)
	id 77111BE2EE7; Sun, 24 May 2026 16:46:48 +0200 (CEST)
Date: Sun, 24 May 2026 16:46:48 +0200
From: Salvatore Bonaccorso <carnil@debian.org>
To: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
Cc: stable@vger.kernel.org, patches@lists.linux.dev,
	Ian Rogers <irogers@google.com>, Namhyung Kim <namhyung@kernel.org>,
	Sasha Levin <sashal@kernel.org>, regressions@lists.linux.dev
Subject: Re: [PATCH 6.12 375/666] perf tool_pmu: Factor tool events into
 their own PMU
Message-ID: <ahMPWN_PZlQLisk4@eldamar.lan>
References: <20260520162111.222830634@linuxfoundation.org>
 <20260520162119.375577583@linuxfoundation.org>
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <20260520162119.375577583@linuxfoundation.org>
X-Spamd-Result: default: False [-1.56 / 15.00];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	R_SPF_ALLOW(-0.20)[+ip4:172.234.253.10:c];
	R_DKIM_ALLOW(-0.20)[gmail.com:s=20251104];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	DMARC_POLICY_SOFTFAIL(0.10)[debian.org : SPF not aligned (relaxed), DKIM not aligned (relaxed),none];
	HAS_LIST_UNSUB(-0.01)[];
	MIME_TRACE(0.00)[0:+];
	DKIM_TRACE(0.00)[gmail.com:+];
	TAGGED_FROM(0.00)[bounces-254033-lists,stable=lfdr.de];
	RCVD_TLS_LAST(0.00)[];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	FORGED_SENDER_MAILLIST(0.00)[];
	MISSING_XM_UA(0.00)[];
	FROM_HAS_DN(0.00)[];
	TO_DN_SOME(0.00)[];
	RCVD_COUNT_FIVE(0.00)[6];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[carnil@debian.org,stable@vger.kernel.org];
	ASN(0.00)[asn:63949, ipnet:172.234.224.0/19, country:SG];
	NEURAL_HAM(-0.00)[-1.000];
	TAGGED_RCPT(0.00)[stable];
	RCPT_COUNT_SEVEN(0.00)[7];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	DBL_BLOCKED_OPENRESOLVER(0.00)[sea.lore.kernel.org:rdns,sea.lore.kernel.org:helo,eldamar.lan:mid]
X-Rspamd-Queue-Id: 413055C2BB2
X-Rspamd-Action: no action
X-Rspamd-Server: lfdr

hi Greg, 
On Wed, May 20, 2026 at 06:19:46PM +0200, Greg Kroah-Hartman wrote:
> 6.12-stable review patch.  If anyone has any objections, please let me know.
> 
> ------------------
> 
> From: Ian Rogers <irogers@google.com>
> 
> [ Upstream commit 240505b2d0adcdc8fd018117e88dc27b09734735 ]
> 
> Rather than treat tool events as a special kind of event, create a
> tool only PMU where the events/aliases match the existing
> duration_time, user_time and system_time events. Remove special
> parsing and printing support for the tool events, but add function
> calls for when PMU functions are called on a tool_pmu.
> 
> Move the tool PMU code in evsel into tool_pmu.c to better encapsulate
> the tool event behavior in that file.

While building now a complete set of packages for Debian for 6.12.91
where perf tools are included as well, I noticed that now the builds
fails. In fact in v6.12.91 

$ cd tools
$ LC_ALL=C.UTF-8 ARCH=x86 make perf

fails with:

[...]
  CC      util/stat.o
util/tool_pmu.c: In function ‘tool_pmu__config_term’:
util/tool_pmu.c:62:49: error: implicit declaration of function ‘parse_events__term_type_str’; did you mean ‘parse_events_term__str’? [-Wimplicit-function-declaration]
   62 |                                                 parse_events__term_type_str(term->type_term),
      |                                                 ^~~~~~~~~~~~~~~~~~~~~~~~~~~
      |                                                 parse_events_term__str
util/tool_pmu.c:61:79: error: format ‘%s’ expects argument of type ‘char *’, but argument 3 has type ‘int’ [-Werror=format=]
   61 |                                                 "unexpected tool event term (%s) %s",
      |                                                                              ~^
      |                                                                               |
      |                                                                               char *
      |                                                                              %d
   62 |                                                 parse_events__term_type_str(term->type_term),
      |                                                 ~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~
      |                                                 |
      |                                                 int
cc1: all warnings being treated as errors
  CC      util/stat-shadow.o
  LD      util/hisi-ptt-decoder/perf-util-in.o
  CC      util/stat-display.o
make[5]: *** [/home/build/linux-stable-rc/tools/build/Makefile.build:105: util/tool_pmu.o] Error 1
make[5]: *** Waiting for unfinished jobs....
  CC      util/perf_api_probe.o
  LD      util/perf-regs-arch/perf-util-in.o
util/cgroup.c: In function ‘evlist__expand_cgroup’:
util/cgroup.c:498:32: error: ‘struct evsel’ has no member named ‘first_wildcard_match’
  498 |                         if (pos->first_wildcard_match)
      |                                ^~
util/cgroup.c:499:38: error: ‘struct evsel’ has no member named ‘first_wildcard_match’
  499 |                                 evsel->first_wildcard_match = pos->first_wildcard_match->priv;
      |                                      ^~
util/cgroup.c:499:66: error: ‘struct evsel’ has no member named ‘first_wildcard_match’
  499 |                                 evsel->first_wildcard_match = pos->first_wildcard_match->priv;
      |                                                                  ^~
make[5]: *** [/home/build/linux-stable-rc/tools/build/Makefile.build:105: util/cgroup.o] Error 1
  LD      util/arm-spe-decoder/perf-util-in.o
  LD      ui/browsers/perf-ui-in.o
  LD      tests/workloads/perf-test-in.o
  LD      ui/perf-ui-in.o
  LD      perf-ui-in.o
  AR      libperf-ui.a
  LD      tests/perf-test-in.o
  LD      perf-test-in.o
  AR      libperf-test.a
  LD      util/scripting-engines/perf-util-in.o
  LD      util/intel-pt-decoder/perf-util-in.o
  LD      perf-in.o
make[4]: *** [/home/build/linux-stable-rc/tools/build/Makefile.build:162: util] Error 2
make[3]: *** [Makefile.perf:789: perf-util-in.o] Error 2
make[3]: *** Waiting for unfinished jobs....
  CC      pmu-events/pmu-events.o
  LD      pmu-events/pmu-events-in.o
make[2]: *** [Makefile.perf:292: sub-make] Error 2
make[1]: *** [Makefile:76: all] Error 2
make: *** [Makefile:93: perf] Error 2

Regards,
Salvatore

