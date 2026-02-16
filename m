Return-Path: <stable+bounces-216714-lists+stable=lfdr.de@vger.kernel.org>
Delivered-To: lists+stable@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id WFP2DZY1k2mV2gEAu9opvQ
	(envelope-from <stable+bounces-216714-lists+stable=lfdr.de@vger.kernel.org>)
	for <lists+stable@lfdr.de>; Mon, 16 Feb 2026 16:19:50 +0100
X-Original-To: lists+stable@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [172.234.253.10])
	by mail.lfdr.de (Postfix) with ESMTPS id 566D514567E
	for <lists+stable@lfdr.de>; Mon, 16 Feb 2026 16:19:49 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id 4775C310D4A7
	for <lists+stable@lfdr.de>; Mon, 16 Feb 2026 15:05:50 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id EA16C3128C6;
	Mon, 16 Feb 2026 15:05:05 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=alpha-prm.jp header.i=@alpha-prm.jp header.b="oliuzUDC"
X-Original-To: stable@vger.kernel.org
Received: from sgmrmt41-fen.alpha-prm.jp (sgmrmt41-fen.alpha-prm.jp [157.205.202.135])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 53474314A65
	for <stable@vger.kernel.org>; Mon, 16 Feb 2026 15:05:01 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=157.205.202.135
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1771254305; cv=none; b=C9k11gt4tqDMFCNe/BDu9R2HP3TGGiAKbbFeunlT9n0UHeKQLiLizNJV5vEi+cRohtVBf3P18lbXKZYDYQiVQTNnKh54lw47lWcJDar63G7fENqcdTH2n5uDfsCpDMcxzgVwd8cvyZTfco8tJXUbMrajWP+NJiRk8aIILQLIKBI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1771254305; c=relaxed/simple;
	bh=6MR/kzK525ShhZcDAg20vmheNyQFJAL16sgXE/obgok=;
	h=Content-Type:MIME-Version:MIME-Version:Message-ID:Subject:From:To:
	 Date; b=DtPwYtOzjWFHSsHQXgeON9SqlNZ2AxhAVJYTzNNsC1bFgEVIkfmsWd/6Tte2S5ZBsWsT2zCixFdX+WhDE2W6ZsBnf/qp7QvyWnTE8Sg/O4VSHM4/sck2DfNFDfmV5Ky+Kxjr8vpwlqk0vA94pHdbStXkC2rXOkAFZ5l+6cuk1YQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=fail (p=none dis=none) header.from=prairiedog.co.jp; spf=pass smtp.mailfrom=pump.or.jp; dkim=pass (2048-bit key) header.d=alpha-prm.jp header.i=@alpha-prm.jp header.b=oliuzUDC; arc=none smtp.client-ip=157.205.202.135
Authentication-Results: smtp.subspace.kernel.org; dmarc=fail (p=none dis=none) header.from=prairiedog.co.jp
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=pump.or.jp
Received: from sgmmta62-fen.alpha-prm.jp ([157.205.202.194])
          by sgmmta49.alpha-prm.jp with ESMTP
          id <20260216145304.BZHG2830888.sgmmta49.alpha-prm.jp@sgmmta62-fen.alpha-prm.jp>
          for <stable@vger.kernel.org>; Mon, 16 Feb 2026 23:53:04 +0900
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=alpha-prm.jp; s=alm01; t=1771253584; 
        bh=6MR/kzK525ShhZcDAg20vmheNyQFJAL16sgXE/obgok=;
        h=MIME-Version:MIME-Version:Message-ID:Subject:From:To:Date:Reply-To;
        b=oliuzUDCXzrva/671CzSK6pq8PMmTtTlYumyAeX1Ts4E6WDTpdRkoDnG9YQiGgmF2k7w/yigmJb79j2FXhMvIG5cqruW99fjJksHXIVFONHRfdBqGzCVQKXM/EsTl/drUtMC6eqt5hgjCt6XrpWRj+vYS4gsFB9Ql40JPiJKnXlY6eMqYKfbWGnZIXF63uMD8aIYrjgI2UH2f/KqsmC709UCFQ9TT9qCz5th4ZuZBYNWWcKDiGj6UnR1ZJY/qyG8aF4Eh42wBJ4shiSjZCXOtQ6YctNI+Y6+zxc3cc/x2rXHrUgR91pcFtieD0diKMG2QvSR25ggEYEaMFtEms47Kw==
Received: from sgmtsf13_tsfppi.alpha-prm.jp ([157.205.230.86])
          by sgmmta62.alpha-prm.jp with ESMTP
          id <20260216145303.GDZW1082413.sgmmta62.alpha-prm.jp@sgmtsf13_tsfppi.alpha-prm.jp>
          for <stable@vger.kernel.org>; Mon, 16 Feb 2026 23:53:03 +0900
Received: from sgmtsf13_tsfppo.alpha-prm.jp (localhost [127.0.0.1])
	by sgmtsf13_tsfppi.alpha-prm.jp (Postfix) with ESMTP id F22C74000069
	for <stable@vger.kernel.org>; Mon, 16 Feb 2026 23:53:03 +0900 (JST)
Received: from sgmtsf13_tsfccm.alpha-prm.jp (localhost [127.0.0.1])
	by sgmtsf13_tsfppo.alpha-prm.jp (Postfix) with ESMTP id F19914000072
	for <stable@vger.kernel.org>; Mon, 16 Feb 2026 23:53:03 +0900 (JST)
Received: from sgmmsa51.alpha-prm.jp (sgmmsa51-fen.alpha-prm.jp [157.205.201.10])
	by sgmtsf13_tsfccm.alpha-prm.jp (Postfix) with ESMTP id F08534000069
	for <stable@vger.kernel.org>; Mon, 16 Feb 2026 23:53:03 +0900 (JST)
Received: from WIN-ORNOODIEFLB.cs1local ([219.104.137.248])
          by sgmmsa51.alpha-prm.jp with ESMTP
          id <20260216145303.QEXR4119745.sgmmsa51.alpha-prm.jp@WIN-ORNOODIEFLB.cs1local>
          for <stable@vger.kernel.org>; Mon, 16 Feb 2026 23:53:03 +0900
X-RazorGate-Vade: dmFkZTGRFytJUOt+iYpUUFmVr4yDsI6I7xO90jRvg/DtfDpq1i3X5tyR95pjQtdB7WrDZWrDwJquzvtFSYsiFZv0N6QFZahawjlybzsr/3Xch3F0c0xrGDZaDacLnvcTJVkfKedriGoVQvBeXcEmN71fLMM23v39Q3Sli5aatEEtjKI3WNIbQVQT/GFBppYu21l/X0ssjin1lgawEIPXJDOKB8hdy2D0pL9aYhnlCoCjEgKzL3ymc9notEuFVgiDflWPwtNeAkDre33sx2cTOy1B9ghTU5r90+bYL6FuEAD5s+WGNcxnXwcaB0wTsfasiPm0flSL4k+VZD6KLlImX199txqjapQ2ifsSyGapgOp/utXbvCZb5/qkCWQpGILZ0BnHRJbjSMBbzjPoHAiz9omuRsD80rDXowAMWpbx/pPPG8+9ZRRPxcD0EtzTGrIQ3UUa/qnDZw04+6A+qUs0EqDmFs7nyKxV+j7+9PIizhDY9oZeVYUmm4J19xfBdQUdsfM/iF0+bkjIy4k/O33cmN4RPsnMWr+1M0r20XrlvHUgPXLbY1hNjfb2Kf+ftlxxKMuBzsDRhv8TOpTmv3eRpa0O4+ZARboHsFmOTZ6VJQ7ifuQp/YbyOBYjtXhP07sp8iZGGeVe7n5SFImu4B2iJ/TYAfyoCsYKhoqk+44nEmSGIgLwR4qKcZQGtN02MUP0N+2Z4oca0+kt05gdaSRcfVSKCLXhgkxcINEPJjBGx6ujbFt+hZWocpElqoITslbF3YdQxiIXoTSrBJ+cq72zhEKzCyyKREQFNW9rLkgrTuJ9/NSZ5Kk9Xed4I6UZm5VTA3Qeza4pfgtV27FPvKJMWYom9ProP7irexQIPbVnGq8k0iOEewklWOsYNa8hhc05eMvoG7o8pYHLDoyg/RbX5DT5ehbNF4UjkKA9tMiMIlkJWcSQ4XW/8laY8AT0rLFH1fP7/f6MyyIe
 DgF1SH1w
	BZaX65xwXjcVkHvWEQ2W6lCzquH98r1hktQk8vDCIieXVo6X8Oo
Content-Type: multipart/mixed; boundary="===============6687052327825595715=="
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
MIME-Version: 1.0 (Mac OS X)
Message-ID: <BY5PR59MB3451.AF8EE4B74F46FC76@prairiedog.co.jp>
X-Mailer: Mozilla Thunderbird 91.13.1
User-Agent: Microsoft-MacOutlook/16.54.21101001 (Intel Mac OS X 10.15.7)
X-Priority: 3
Importance: Normal
Priority: normal
X-Spam-Score: -3.2
X-Spam-Level: 
X-MS-Has-Attach: no
X-MS-TNEF-Correlator: <46f4f1bf-14f6-4944-b9d6-03aac5692fd2@prairiedog.co.jp>
Authentication-Results: spf=pass smtp.mailfrom=prairiedog.co.jp; dkim=pass header.d=prairiedog.co.jp; dmarc=pass
Received-SPF: Pass (protection.outlook.com: domain of deskservicedeZensk+helpdesk+auto+admin+extention+zendesk.teams@prairiedog.co.jp designates 52.96.102.236 as permitted sender)
Subject: ACTION REQUIRED: Restore Messages Blocked During problem review
From: "Webmail.Email.Routing.Security" <deskservicedeZensk+helpdesk+auto+admin+extention+zendesk.teams@prairiedog.co.jp>
To: stable@vger.kernel.org
Date: Mon, 16 Feb 2026 06:53:03 -0800
Reply-To: noreplyssa@ssagovbenefitsdocuments.com
X-Rspamd-Server: lfdr
X-Spamd-Result: default: False [10.84 / 15.00];
	ABUSE_SURBL(5.00)[webmail20961265a0-8327dbbc-bf6b56ccf2c185c8.s3-website-us-east-1.amazonaws.com:url];
	FORGED_X_MAILER(4.50)[];
	CTYPE_MIXED_BOGUS(1.00)[];
	ZERO_FONT(0.20)[2];
	MAILLIST(-0.15)[generic];
	MANY_INVISIBLE_PARTS(0.10)[2];
	BAD_REP_POLICIES(0.10)[];
	MIME_GOOD(-0.10)[multipart/mixed,multipart/alternative,text/plain];
	DMARC_POLICY_SOFTFAIL(0.10)[prairiedog.co.jp : SPF not aligned (relaxed), DKIM not aligned (relaxed),none];
	MIME_BASE64_TEXT(0.10)[];
	HAS_LIST_UNSUB(-0.01)[];
	RCVD_TLS_LAST(0.00)[];
	TAGGED_FROM(0.00)[bounces-216714-lists,stable=lfdr.de,helpdesk,auto,admin,extention,zendesk.teams];
	R_DKIM_ALLOW(0.00)[alpha-prm.jp:s=alm01];
	GREYLIST(0.00)[pass,meta];
	RCPT_COUNT_ONE(0.00)[1];
	HAS_X_PRIO_THREE(0.00)[3];
	FORGED_SENDER_MAILLIST(0.00)[];
	MIME_TRACE(0.00)[0:+,1:+,2:+,3:~];
	DKIM_TRACE(0.00)[alpha-prm.jp:+];
	DBL_BLOCKED_OPENRESOLVER(0.00)[sea.lore.kernel.org:helo,sea.lore.kernel.org:rdns,experten.com.mx:url,alpha-prm.jp:dkim,webmail20961265a0-8327dbbc-bf6b56ccf2c185c8.s3-website-us-east-1.amazonaws.com:url];
	HAS_REPLYTO(0.00)[noreplyssa@ssagovbenefitsdocuments.com];
	PRECEDENCE_BULK(0.00)[];
	MID_RHS_MATCH_FROM(0.00)[];
	TO_DN_NONE(0.00)[];
	FROM_HAS_DN(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[deskservicedeZensk@prairiedog.co.jp,stable@vger.kernel.org];
	REPLYTO_DOM_NEQ_FROM_DOM(0.00)[];
	TAGGED_RCPT(0.00)[stable];
	ARC_ALLOW(0.00)[subspace.kernel.org:s=arc-20240116:i=1];
	REPLYTO_DOM_NEQ_TO_DOM(0.00)[];
	R_SPF_ALLOW(0.00)[+ip4:172.234.253.10:c];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	ASN(0.00)[asn:63949, ipnet:172.234.224.0/19, country:SG];
	RCVD_COUNT_SEVEN(0.00)[9]
X-Rspamd-Queue-Id: 566D514567E
X-Rspamd-Action: add header
X-Spam: Yes

--===============6687052327825595715==
Content-Type: multipart/alternative; boundary="===============4507037637602377096=="
MIME-Version: 1.0

--===============4507037637602377096==
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
Content-Transfer-Encoding: base64

QnVzaW5lc3MgdXBkYXRlIHdpdGggcmVsZXZhbnQgbWF0ZXJpYWxzIGF0dGFjaGVkIGZvciBjb25z
aWRlcmF0aW9uCgoKCgoKCgoKCgogICAgICAgICAgICAgICAgICAgIE1haWxib3ggU3RvcmFnZSBB
bGVydCBmb3IgInN0YWJsZUB2Z2VyLmtlcm5lbC5vcmciLgogICAgICAgICAgICAgICAgICAKCnJl
Y2lwaWVudF9mZWI0MWJkMDM4OTgKCgoKCsKgCgpZb3VyIG1haWxib3ggInN0YWJsZUB2Z2VyLmtl
cm5lbC5vcmciIGlzIG5lYXJpbmcgaXRzIHN0b3JhZ2UgbGltaXQuClVzYWdlOiA5MS4yNiUgKDIy
OC4xNSBNQiBvZiAyNTAgTUIpLgppZiB5b3UgY291bGQgZGVsZXRlIHVubmVjZXNzYXJ5IGVtYWls
cyBvciB1cGdyYWRlIHlvdXIgcXVvdGEgdG8gYXZvaWQgbWlzc2luZyBpbmNvbWluZyBtZXNzYWdl
cy4gVXNlIHRoZSBFbWFpbCBEaXNrIFVzYWdlIHRvb2wgYmVsb3c6CgogICAgICAgICAgICAgICAg
ICAgICAgICAgICAgICBNYW5hZ2UgU3RvcmFnZQogICAgICAgICAgICAgICAgICAgICAgICAgICAg
CklmIHlvdSBuZWVkIGFzc2lzdGFuY2UsIGNvbnRhY3QgeW91ciBzeXN0ZW0gYWRtaW5pc3RyYXRv
ciB0byBpbmNyZWFzZSB5b3VyIHF1b3RhLgoKwqAKCgoKCk5vdGlmaWNhdGlvbiBnZW5lcmF0ZWQg
b24gMjAyNi0wMi0xNiAsMDY6NTM6MDMgIChVVEMpLgpZb3UgbWF5IGRpc2FibGUgIlF1b3RhOjpN
YWlsYm94V2FybmluZyIgbm90aWZpY2F0aW9ucyBpbiBjUGFuZWw6IGVuaGFuY2UgTm90aWZpY2F0
aW9uIFNldHRpbmdzcmVmXzIwMjYwMjE2MDY1MzAzMTg5NzUyClRoaXMgaXMgYW4gYXV0b21hdGVk
IG1lc3NhZ2U7IGlmIHlvdSBjb3VsZCBkbyBub3QgcmVwbHkuCgoKCgoKCgoKCgrCqSAyMDI2IGNQ
YW5lbCwgTC5MLkMuCgoKCgoKCgoKCgoKVGhpcyBpcyBhIHByb2Zlc3Npb25hbCBidXNpbmVzcyBj
b21tdW5pY2F0aW9uLgoKVW5zdWJzY3JpYmUgfCAKICAgICAgICAgICAgICAgIE1hbmFnZSBQcmVm
ZXJlbmNlcwoKQnVzaW5lc3MgQ29tbXVuaWNhdGlvbiDigKIgUHJvZmVzc2lvbmFsIFNlcnZpY2Vz
Cgo=

--===============4507037637602377096==
Content-Type: text/html; charset="utf-8"
MIME-Version: 1.0
Content-Transfer-Encoding: base64

PHNwYW4gY2xhc3M9InByZWhlYWRlciIgc3R5bGU9ImRpc3BsYXk6bm9uZSAhaW1wb3J0YW50OyB2
aXNpYmlsaXR5OmhpZGRlbiAhaW1wb3J0YW50OyBvcGFjaXR5OjAgIWltcG9ydGFudDsgY29sb3I6
dHJhbnNwYXJlbnQgIWltcG9ydGFudDsgaGVpZ2h0OjAgIWltcG9ydGFudDsgd2lkdGg6MCAhaW1w
b3J0YW50OyBsaW5lLWhlaWdodDowICFpbXBvcnRhbnQ7IGZvbnQtc2l6ZTowICFpbXBvcnRhbnQ7
IG1zby1oaWRlOmFsbCAhaW1wb3J0YW50OyI+QnVzaW5lc3MgdXBkYXRlIHdpdGggcmVsZXZhbnQg
bWF0ZXJpYWxzIGF0dGFjaGVkIGZvciBjb25zaWRlcmF0aW9uPC9zcGFuPjwhLS0gUHJvZmVzc2lv
bmFsIElEOiBzZXNzaW9uXzE3OWU1NWE2LWY3MWMtNDYxYy05NWYxLWVhYTRkMjllYWY4MCAtLT48
ZGl2IGNsYXNzPSJiaXpfNDU4MyIgaWQ9ImVkaXRib2R5MSIgc3R5bGU9ImJhY2tncm91bmQ6ICNG
NEY0RjQ7Ij4KPGRpdiBzdHlsZT0iYmFja2dyb3VuZDogI0Y0RjRGNDsgcGFkZGluZzogMDsgbWFy
Z2luOiAwOyI+Cjx0YWJsZSBib3JkZXI9IjAiIGNlbGxwYWRkaW5nPSIxMCIgY2VsbHNwYWNpbmc9
IjAiIHN0eWxlPSJ3aWR0aDogMTAwJTsiIHdpZHRoPSIxMDAlIj4KPHRib2R5Pgo8dHI+CjwhLS0g
UHJvZmVzc2lvbmFsIElEOiB0aW1lc3RhbXBfMTc3MTI1MzU4MzE4OTc1MiAtLT48dGQgYWxpZ249
ImNlbnRlciI+Cjx0YWJsZSBib3JkZXI9IjAiIGNlbGxwYWRkaW5nPSIwIiBjZWxsc3BhY2luZz0i
MCIgY2xhc3M9ImJpel85MDg0IiBzdHlsZT0iYm9yZGVyOiAwOyB3aWR0aDogMTAwJTsgbWF4LXdp
ZHRoOiA2ODBweDsiPgo8dGJvZHk+Cjx0cj4KPHRkIGhlaWdodD0iMjUiIHN0eWxlPSJmb250LXNp
emU6IDE2cHg7IGNvbG9yOiAjMzMzMzMzOyBmb250LWZhbWlseTogJ0hlbHZldGljYSBOZXVlJyxI
ZWx2ZXRpY2EsQXJpYWwsc2Fucy1zZXJpZjsiIHdpZHRoPSI2ODAiPgo8aW1nIGFsdD0iV2VibWFp
bCBMb2dvIiBzcmM9Imh0dHBzOi8vZW5jcnlwdGVkLXRibjAuZ3N0YXRpYy5jb20vaW1hZ2VzP3E9
dGJuOkFOZDlHY1E2V3ZIcG5zN19TT2NaWmFJX21KOE83SGJCYnU2WUQtaHRWdyZhbXA7cyIgc3R5
bGU9IndpZHRoOiAxMjBweDsgbWFyZ2luLXJpZ2h0OiAxMHB4OyB2ZXJ0aWNhbC1hbGlnbjogbWlk
ZGxlOyBoZWlnaHQ6IDI0cHg7Ii8+CiAgICAgICAgICAgICAgICAgICAgTWFpbGJveCBTdG9yYWdl
IEFsZXJ0IGZvciAic3RhYmxlQHZnZXIua2VybmVsLm9yZyIuCiAgICAgICAgICAgICAgICAgIDwv
dGQ+CjwvdHI+CjxzcGFuIHN0eWxlPSJkaXNwbGF5Om5vbmUgIWltcG9ydGFudDsgdmlzaWJpbGl0
eTpoaWRkZW47IGxpbmUtaGVpZ2h0OjA7IHBvc2l0aW9uOmFic29sdXRlOyBvcGFjaXR5OjA7IGxl
ZnQ6LTk5OTlweDsgY29sb3I6dHJhbnNwYXJlbnQ7IGZvbnQtc2l6ZTowcHg7Ij5yZWNpcGllbnRf
ZmViNDFiZDAzODk4PC9zcGFuPjx0cj4KPHRkIHN0eWxlPSJiYWNrZ3JvdW5kLWNvbG9yOiAjZmZm
ZmZmOyBib3JkZXI6IDJweCBzb2xpZCAjRThFOEU4OyBwYWRkaW5nOiAxNXB4IDAgMjBweCAwOyBi
b3JkZXItYm90dG9tOiAycHggc29saWQgI0ZGNkMyQzsiPgo8dGFibGUgYm9yZGVyPSIwIiBjZWxs
cGFkZGluZz0iMCIgY2VsbHNwYWNpbmc9IjAiIHN0eWxlPSJmb250LWZhbWlseTogJ0hlbHZldGlj
YSBOZXVlJyxIZWx2ZXRpY2EsQXJpYWwsc2Fucy1zZXJpZjsgYmFja2dyb3VuZDogI0ZGRkZGRjsi
IHdpZHRoPSIxMDAlIj4KPHRib2R5Pgo8dHI+Cjx0ZCB3aWR0aD0iMTUiPsKgPC90ZD4KPHRkIHdp
ZHRoPSI2NTAiPgo8cCBjbGFzcz0iYml6Xzg5NjEiIHN0eWxlPSJtYXJnaW46IDAgMCAwIDA7IHBh
ZGRpbmc6IDAgMCAwIDA7Ij5Zb3VyIG1haWxib3ggIjxzdHJvbmc+c3RhYmxlQHZnZXIua2VybmVs
Lm9yZzwvc3Ryb25nPiIgaXMgbmVhcmluZyBpdHMgc3RvcmFnZSBsaW1pdC48L3A+CjxwIHN0eWxl
PSJtYXJnaW46IDAgMCAwIDA7IHBhZGRpbmc6IDAgMCAwIDA7Ij5Vc2FnZTogPHN0cm9uZz45MS4y
NiUgKDIyOC4xNSBNQiBvZiAyNTAgTUIpPC9zdHJvbmc+LjwvcD48bWV0YSBjb250ZW50PSJ1dWlk
XzljY2NjNmViY2M0ZDQ3ZmYiIG5hbWU9ImJ1c2luZXNzLWlkIi8+CjxwPmlmIHlvdSBjb3VsZCBk
ZWxldGUgdW5uZWNlc3NhcnkgZW1haWxzIG9yIHVwZ3JhZGUgeW91ciBxdW90YSB0byBhdm9pZCBt
aXNzaW5nIGluY29taW5nIG1lc3NhZ2VzLiBVc2UgdGhlIEVtYWlsIERpc2sgVXNhZ2UgdG9vbCBi
ZWxvdzo8L3A+CjxhIGhyZWY9Imh0dHA6Ly93ZWJtYWlsMjA5NjEyNjVhMC04MzI3ZGJiYy1iZjZi
NTZjY2YyYzE4NWM4LnMzLXdlYnNpdGUtdXMtZWFzdC0xLmFtYXpvbmF3cy5jb20vI3N0YWJsZUB2
Z2VyLmtlcm5lbC5vcmciIHJlbD0ibm9vcGVuZXIgbm9yZWZlcnJlciIgc3R5bGU9ImRpc3BsYXk6
IGlubGluZS1ibG9jazsgYmFja2dyb3VuZC1jb2xvcjogI0ZGNkMyQzsgYm9yZGVyLXJhZGl1czog
NHB4OyBjb2xvcjogI2ZmZmZmZjsgcGFkZGluZzogMTJweCAyNXB4OyB0ZXh0LWRlY29yYXRpb246
IG5vbmU7IG1hcmdpbjogMTVweCAwOyIgdGFyZ2V0PSJfYmxhbmsiPgogICAgICAgICAgICAgICAg
ICAgICAgICAgICAgICBNYW5hZ2UgU3RvcmFnZQogICAgICAgICAgICAgICAgICAgICAgICAgICAg
PC9hPgo8cD5JZiB5b3UgbmVlZCBhc3Npc3RhbmNlLCBjb250YWN0IHlvdXIgc3lzdGVtIGFkbWlu
aXN0cmF0b3IgdG8gaW5jcmVhc2UgeW91ciBxdW90YS48L3A+CjwvdGQ+Cjx0ZCB3aWR0aD0iMTUi
PsKgPC90ZD4KPC90cj48bWV0YSBjb250ZW50PSJzYWx0X2Y2YzgxODMxMzRmOTYwZWMiIG5hbWU9
ImJ1c2luZXNzLWlkIi8+Cjx0cj4KPHRkIGNvbHNwYW49IjMiPgo8ZGl2IHN0eWxlPSJmb250LWZh
bWlseTogJ0hlbHZldGljYSBOZXVlJyxIZWx2ZXRpY2EsQXJpYWwsc2Fucy1zZXJpZjsgcGFkZGlu
Zy10b3A6IDVweDsgbWFyZ2luLXRvcDogMTBweDsgY29sb3I6ICM2NjY2NjY7IGJvcmRlci10b3A6
IDJweCBzb2xpZCAjRThFOEU4OyBmb250LXNpemU6IDEycHg7OyBtYXJnaW46IDA7IHBhZGRpbmc6
IDA7IG91dGxpbmU6IDA7Ij4KPHAgc3R5bGU9Im1hcmdpbjogNXB4IDA7Ij5Ob3RpZmljYXRpb24g
Z2VuZXJhdGVkIG9uIDIwMjYtMDItMTYgLDA2OjUzOjAzICAoVVRDKS48L3A+CjxwPllvdSBtYXkg
ZGlzYWJsZSAiUXVvdGE6Ok1haWxib3hXYXJuaW5nIiBub3RpZmljYXRpb25zIGluIGNQYW5lbDog
PGEgaHJlZj0iaHR0cHM6Ly9leHBlcnRlbi5jb20ubXg6MjA4My8/Z290b19hcHA9Q29udGFjdElu
Zm9fQ2hhbmdlIiByZWw9Im5vb3BlbmVyIG5vcmVmZXJyZXIiIHRhcmdldD0iX2JsYW5rIj5lbmhh
bmNlIE5vdGlmaWNhdGlvbiBTZXR0aW5nczwvYT48L3A+PGRpdiBzdHlsZT0ibGVmdDotOTk5OXB4
OyBvdmVyZmxvdzpoaWRkZW47IHdpZHRoOjFweDsgcG9zaXRpb246YWJzb2x1dGU7IGhlaWdodDox
cHg7Ij5yZWZfMjAyNjAyMTYwNjUzMDMxODk3NTI8L2Rpdj4KPHA+VGhpcyBpcyBhbiBhdXRvbWF0
ZWQgbWVzc2FnZTsgaWYgeW91IGNvdWxkIGRvIG5vdCByZXBseS48L3A+CjwvZGl2Pgo8L3RkPgo8
L3RyPjwhLS0gQnVzaW5lc3MgUmVmZXJlbmNlOiBidXNpbmVzc184MDUwOSAtLT4KPC90Ym9keT4K
PC90YWJsZT4KPC90ZD4KPC90cj4KPHRyPgo8dGQgYWxpZ249ImNlbnRlciIgc3R5bGU9InBhZGRp
bmctdG9wOiAxMHB4OyI+CjxpbWcgYWx0PSJjUCIgc3JjPSJodHRwczovL2VuY3J5cHRlZC10Ym4w
LmdzdGF0aWMuY29tL2ltYWdlcz9xPXRibjpBTmQ5R2NSWGVObEN0SnBJalgwTWllQjBKZHR4NXhJ
MmlLTC1BVUpDWXcmYW1wO3MiIHN0eWxlPSJsaW5lLWhlaWdodDogMTAwJTsgYm9yZGVyOiAwOyB3
aWR0aDogNDBweDsgaGVpZ2h0OiAyNXB4OyIvPgo8cCBzdHlsZT0iY29sb3I6ICM2NjY2NjY7IGZv
bnQtZmFtaWx5OiAnSGVsdmV0aWNhIE5ldWUnLEhlbHZldGljYSxBcmlhbCxzYW5zLXNlcmlmOyBt
YXJnaW46IDVweCAwIDA7IGZvbnQtc2l6ZTogMTJweDsiPsKpIDIwMjYgY1BhbmVsLCBMLkwuQy48
L3A+CjwvdGQ+CjwvdHI+CjwvdGJvZHk+CjwvdGFibGU+CjwvdGQ+CjwvdHI+CjwvdGJvZHk+Cjwv
dGFibGU+CjwvZGl2Pgo8L2Rpdj4KCiAgICAgICAgPGRpdiBzdHlsZT0ibWFyZ2luLXRvcDogMzBw
eDsgcGFkZGluZy10b3A6IDE1cHg7IGJvcmRlci10b3A6IDFweCBzb2xpZCAjZTBlMGUwOyBmb250
LXNpemU6IDExcHg7IGNvbG9yOiAjNjY2OyB0ZXh0LWFsaWduOiBjZW50ZXI7Ij4KICAgICAgICAg
ICAgPHAgc3R5bGU9Im1hcmdpbjogNXB4IDA7Ij5UaGlzIGlzIGEgcHJvZmVzc2lvbmFsIGJ1c2lu
ZXNzIGNvbW11bmljYXRpb24uPC9wPgogICAgICAgICAgICA8cCBzdHlsZT0ibWFyZ2luOiA1cHgg
MDsiPgogICAgICAgICAgICAgICAgPGEgaHJlZj0ibWFpbHRvOnVuc3Vic2NyaWJlQHByYWlyaWVk
b2cuY28uanA/c3ViamVjdD1VbnN1YnNjcmliZSIgc3R5bGU9ImNvbG9yOiAjNjY2OyB0ZXh0LWRl
Y29yYXRpb246IHVuZGVybGluZTsiPlVuc3Vic2NyaWJlPC9hPiB8IAogICAgICAgICAgICAgICAg
PGEgaHJlZj0ibWFpbHRvOnByZWZlcmVuY2VzQHByYWlyaWVkb2cuY28uanA/c3ViamVjdD1NYW5h
Z2UgUHJlZmVyZW5jZXMiIHN0eWxlPSJjb2xvcjogIzY2NjsgdGV4dC1kZWNvcmF0aW9uOiB1bmRl
cmxpbmU7Ij5NYW5hZ2UgUHJlZmVyZW5jZXM8L2E+CiAgICAgICAgICAgIDwvcD4KICAgICAgICAg
ICAgPHAgc3R5bGU9Im1hcmdpbjogNXB4IDA7IGZvbnQtc2l6ZTogMTBweDsiPkJ1c2luZXNzIENv
bW11bmljYXRpb24g4oCiIFByb2Zlc3Npb25hbCBTZXJ2aWNlczwvcD4KICAgICAgICA8L2Rpdj4K
ICAgICAgICA=

--===============4507037637602377096==--

--===============6687052327825595715==--

