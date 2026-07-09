Return-Path: <stable+bounces-273012-lists+stable=lfdr.de@vger.kernel.org>
Delivered-To: lists+stable@lfdr.de
Received: from mail.lfdr.de
	by mail.lfdr.de with LMTP
	id 5GRXBurhT2rVpgIAu9opvQ
	(envelope-from <stable+bounces-273012-lists+stable=lfdr.de@vger.kernel.org>)
	for <lists+stable@lfdr.de>; Thu, 09 Jul 2026 20:01:14 +0200
X-Original-To: lists+stable@lfdr.de
Received: from tor.lore.kernel.org (tor.lore.kernel.org [172.105.105.114])
	by mail.lfdr.de (Postfix) with ESMTPS id 95A5C73417F
	for <lists+stable@lfdr.de>; Thu, 09 Jul 2026 20:01:13 +0200 (CEST)
Authentication-Results: mail.lfdr.de;
	dkim=pass header.d=gmail.com header.s=20251104 header.b=QuY7Ial7;
	dmarc=pass (policy=none) header.from=gmail.com;
	spf=pass (mail.lfdr.de: domain of "stable+bounces-273012-lists+stable=lfdr.de@vger.kernel.org" designates 172.105.105.114 as permitted sender) smtp.mailfrom="stable+bounces-273012-lists+stable=lfdr.de@vger.kernel.org";
	arc=pass ("subspace.kernel.org:s=arc-20240116:i=2")
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by tor.lore.kernel.org (Postfix) with ESMTP id 402A03015A76
	for <lists+stable@lfdr.de>; Thu,  9 Jul 2026 18:00:48 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 781B04DB540;
	Thu,  9 Jul 2026 18:00:45 +0000 (UTC)
X-Original-To: stable@vger.kernel.org
Received: from mail-pj1-f53.google.com (mail-pj1-f53.google.com [209.85.216.53])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 10EBB3AC0C2
	for <stable@vger.kernel.org>; Thu,  9 Jul 2026 18:00:43 +0000 (UTC)
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1783620045; cv=pass; b=lbTrjvCl0W7IHsLlI9Db5v1cLn4QQXDIRTn4bbSOxQyUvNo6E6aNnm8TWRQAb1rpTy8zbcp8MRUzqypaJEnYJgNJMkWCmje7ueZ9msSxKRs4aSZsRVg173WyQpYcRezKCWB4EykpOiMpLQuSmd9cjEYVjf9VIugy5vj++D4c63Q=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1783620045; c=relaxed/simple;
	bh=uPnH2+lrTqYlvux5uooS+BPCLgNqhuSH8RvnGSVa7wU=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=p9toi2ZFNExjSLiiiBTS6N3OH5RtfhkWas1tiAMy1aeBjaX6pOnKl2M9rhQgRcUgfMSfMkGBv0g/nSZ6w06hlSKIpW2DKzNDfnH3NotCU0dOJC7r6WVEiHRh0qtlPu+hXRJYifeHBcLo8HQGh8yb2AWk/kmET+ZJy0xohMr7uvI=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=QuY7Ial7; arc=pass smtp.client-ip=209.85.216.53
Received: by mail-pj1-f53.google.com with SMTP id 98e67ed59e1d1-381f03d7be0so40337a91.1
        for <stable@vger.kernel.org>; Thu, 09 Jul 2026 11:00:43 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; t=1783620043; cv=none;
        d=google.com; s=arc-20260327;
        b=himdNCPb7OV1LRKB8xRxgxCLvggufzL6Wvy43o87a4xOr60N9sq0cfmSkhBCs1iZjI
         TIzrHuh2Qzq5a37vNP/A3AgW49kvBFmNjnLLaqjxpVxygcQVt9HI7f9ILwfqu23gINt3
         pN9nCfjXVuo/Wt5ULhySJbKThyPTpM1sgsNUQK0Rw6241M1XM/9Nxc4+DqbifYOnf0H/
         CL9QIKCMNUDD004GINn8yQFwosvZu9HhiKMkXBekEdgGHw4DXpfjEN9x8Bg+bkAOm3/e
         0Qw/5x4598bfLg7Lq+WEBeJKR3jM6+IP8f88PCJmuhop+uauSBNAqgUXA1E3s4zB+Q2P
         ruWg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20260327;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:dkim-signature;
        bh=5miHMUovz2GTkfsITKZmYCEXMLzkG0I0sBxTQyUjYzY=;
        fh=TDQ48dl9sRJDzhU+mhD945N+htsMTlaUJSLCSt5K964=;
        b=avgOQsL93Weopo7VnKY9tTAPjBBRJ9gkCg5SpQtVfbTJVEKp8ez9zaeGD6IhbixTGA
         kTM8Pbrm9TkLu1UN25cvtljYp9H6ncygpC4ahPfuA+weD5Wiei4Wpu0A2vOnED07J8ws
         JinqlcHIfQHsosh3emkCT5RIp3OIKVz9nQIm8CEwmtj5hN6yc8KW/1pUGCVHgf4/wXzJ
         teDgKDXD/CsDlK38q9l4p29H2cA56h9GSrDHVj+o3Dz3G+1O7CHOMDgdrRLyWLJZ3GyJ
         oaXSKAtmNqjBLP56xVZewZ9hyE8YdEqkNkuPPzIgFixGESeNUiGnpgqgm19qL6pzJSgw
         TCLA==;
        darn=vger.kernel.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1783620043; x=1784224843; darn=vger.kernel.org;
        h=content-transfer-encoding:content-type:cc:to:subject:message-id
         :date:from:in-reply-to:references:mime-version:from:to:cc:subject
         :date:message-id:reply-to:content-type;
        bh=5miHMUovz2GTkfsITKZmYCEXMLzkG0I0sBxTQyUjYzY=;
        b=QuY7Ial7+OCLeeFrmZV13TnP2Gkb7kAA6lXtVyt85uNwqIfA67V4tNdtIJ1teZnJWh
         4QOkLEvZfPbziHBGNwx988AxUPRg/TBIVLgZAHcXDPTGjb3i+70bM3CP6XPwSYpqUhdJ
         lODr3D4jJaXW6lLDEwFQ2G+9exp0bb1sray2J7Q+BJB2U5Epdin/Tm+UT2VvDGWHd3z/
         R9mImgsQ440WRQlW1IKVuQVY4c8mXpaYZXjgpwG54l+EFCfq8WRQk8BxlOeNWSP5DMqR
         t7ZDZxPUu1CgCy1QNSBZjNcvZQ0D19dydlCHIukeMUmvoJwwkW+YZcIZSESpUa1+HSh1
         8Ing==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1783620043; x=1784224843;
        h=content-transfer-encoding:content-type:cc:to:subject:message-id
         :date:from:in-reply-to:references:mime-version:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=5miHMUovz2GTkfsITKZmYCEXMLzkG0I0sBxTQyUjYzY=;
        b=EbNC7vNsHiXb/w/Fz1pGVuFGt3auO/cqetyWjMxAIw/e1psd2tUMVFdu55/atBecdc
         ijvj14XxEZqSVWqhRwdP1iDRQUO7kx2gCzR42tTW9bpIiOl3eU03d3+yejGxYNBUw2pl
         gGRzD5HDlmm7EBIkDu4EzlnXQG9xT1j5TJPcgYraV1KczxxvB7V/I14jbtc0yw2LJTO1
         EbtnZ791uFfcqVC8t1c+VY8RORGXa2lJHyC7iXZkfCnLTt5AitGaztp2KkvQA0X/RMfF
         ddE52AVyqQimu/iCczWwuQYjWN3qL2oxtzcTOTIdHfzO7IzNVrIKMMtXwjtfjLud4Atl
         ydcw==
X-Forwarded-Encrypted: i=1; AHgh+RoYnqgYuobTAZG9LLX4PZ7rqr0JpcLgtHYz/BdIy5eOChqaFJfse/znhKvD4mN1vIANuYGFasg=@vger.kernel.org
X-Gm-Message-State: AOJu0YyM5CcBkQeqKV+rrARbknPFJrCpaDjWCvSHlxCFfln53bPIb/Qz
	dcxGYiaZP+WOxdzOgitxBfr4VzjObAQXsnSpnIUDcQTZdbvuZAUbe0SHPlmepuL6QXSDrb1XpvM
	ytzASfKV4HxXe2AWxJFjzqrV+oKX0E6w=
X-Gm-Gg: AfdE7cnqiFzbj4XdRwfghHdVrEygkDmowjx+p+udBlVztx8TSuVwF0BhKhL+gbfiDn5
	fyvlOj7yDa9k2cBq5cJuSLjPYyAiSicXv79xbVgLzshdG0fMcZ5+x6Uw/+oX2g3MbOWPJg2oWjL
	jLovFANAmT5XShpZixcQ9bqIxx4jSuPy76ag8SCMgjgFqbfOQnQ/qvRylomlytYU8WMdlH0mOnj
	HQBJ2nuZ+WkTyl88+1mh88ugU526SYglSG9OAdrFAoKijYhAllH4BOlvbiQm2DOSkVvyAS37eZu
	JFxzzmz2Ck8gLY238iBVYJh40M8ljkXBwympl8mqQ3C/pVOuzyEk0ut3nZhOdI4ssjJZiLZsLwC
	YZF+O/yni1dHE
X-Received: by 2002:a17:90b:390e:b0:381:77cd:38ca with SMTP id
 98e67ed59e1d1-38a20c48ce0mr4043790a91.4.1783620043192; Thu, 09 Jul 2026
 11:00:43 -0700 (PDT)
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <2026070939-ranged-unmapped-3ab9@gregkh>
In-Reply-To: <2026070939-ranged-unmapped-3ab9@gregkh>
From: Miguel Ojeda <miguel.ojeda.sandonis@gmail.com>
Date: Thu, 9 Jul 2026 20:00:30 +0200
X-Gm-Features: AUfX_mytC6wawjyvlVr0JLhXAcqj0w-tFmSn1Cyrt2fOa4lyub226kGyZ2rGitY
Message-ID: <CANiq72=8yTH2qGiq8LkvVNPO7VVWwtgtoyEeV+dW-VYZyRq0BA@mail.gmail.com>
Subject: Re: FAILED: patch "[PATCH] rust: kasan: KASAN+RUST requires clang"
 failed to apply to 6.18-stable tree
To: gregkh@linuxfoundation.org
Cc: aliceryhl@google.com, gary@garyguo.net, ojeda@kernel.org, 
	stable@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
X-Rspamd-Action: no action
X-Spamd-Result: default: False [-2.16 / 15.00];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=2];
	DMARC_POLICY_ALLOW(-0.50)[gmail.com,none];
	R_SPF_ALLOW(-0.20)[+ip4:172.105.105.114:c];
	R_DKIM_ALLOW(-0.20)[gmail.com:s=20251104];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	RCVD_TLS_LAST(0.00)[];
	TAGGED_FROM(0.00)[bounces-273012-lists,stable=lfdr.de];
	RCVD_COUNT_THREE(0.00)[4];
	FROM_HAS_DN(0.00)[];
	FORGED_SENDER(0.00)[miguelojedasandonis@gmail.com,stable@vger.kernel.org];
	FREEMAIL_FROM(0.00)[gmail.com];
	FORGED_RECIPIENTS(0.00)[m:gregkh@linuxfoundation.org,m:aliceryhl@google.com,m:gary@garyguo.net,m:ojeda@kernel.org,m:stable@vger.kernel.org,s:lists@lfdr.de];
	MIME_TRACE(0.00)[0:+];
	FORGED_SENDER_MAILLIST(0.00)[];
	FORWARDED(0.00)[lists@lfdr.de];
	DKIM_TRACE(0.00)[gmail.com:+];
	FORGED_RECIPIENTS_FORWARDING(0.00)[];
	RCPT_COUNT_FIVE(0.00)[5];
	FORGED_SENDER_FORWARDING(0.00)[];
	TO_DN_NONE(0.00)[];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[miguelojedasandonis@gmail.com,stable@vger.kernel.org];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	ALIAS_RESOLVED(0.00)[];
	TAGGED_RCPT(0.00)[stable];
	MID_RHS_MATCH_FROMTLD(0.00)[];
	MISSING_XM_UA(0.00)[];
	ASN(0.00)[asn:63949, ipnet:172.105.96.0/20, country:SG];
	DBL_BLOCKED_OPENRESOLVER(0.00)[linuxfoundation.org:email,mail.gmail.com:mid,vger.kernel.org:from_smtp,tor.lore.kernel.org:helo,tor.lore.kernel.org:rdns]
X-Rspamd-Server: lfdr
X-Rspamd-Queue-Id: 95A5C73417F

On Thu, Jul 9, 2026 at 7:36=E2=80=AFPM <gregkh@linuxfoundation.org> wrote:
>
> The patch below does not apply to the 6.18-stable tree.
> If someone wants it applied there, or to any other stable or longterm
> tree, then please email the backport, including the original git commit
> id to <stable@vger.kernel.org>.
>
> To reproduce the conflict and resubmit, you may use the following command=
s:
>
> git fetch https://git.kernel.org/pub/scm/linux/kernel/git/stable/linux.gi=
t/ linux-6.18.y
> git checkout FETCH_HEAD
> git cherry-pick -x 5b271543d0f08e9733d4732721e960e285f6448f
> # <resolve conflicts, build, test, etc.>
> git commit -s
> git send-email --to '<stable@vger.kernel.org>' --in-reply-to '2026070939-=
ranged-unmapped-3ab9@gregkh' --subject-prefix 'PATCH 6.18.y' 'HEAD^..'

Done -- by the way, I assume Google uses

  72d33b8bfeac ("rust: kasan: add support for Software Tag-Based KASAN")

as well. It is not a bug fix, but if Google is using it and it works,
then it guess it could be added too.

Cheers,
Miguel

