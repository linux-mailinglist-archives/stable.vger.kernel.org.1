Return-Path: <stable+bounces-230395-lists+stable=lfdr.de@vger.kernel.org>
Delivered-To: lists+stable@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id 05+ZBip4xGkpzgQAu9opvQ
	(envelope-from <stable+bounces-230395-lists+stable=lfdr.de@vger.kernel.org>)
	for <lists+stable@lfdr.de>; Thu, 26 Mar 2026 01:04:58 +0100
X-Original-To: lists+stable@lfdr.de
Received: from tor.lore.kernel.org (tor.lore.kernel.org [172.105.105.114])
	by mail.lfdr.de (Postfix) with ESMTPS id 7E90032D871
	for <lists+stable@lfdr.de>; Thu, 26 Mar 2026 01:04:57 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by tor.lore.kernel.org (Postfix) with ESMTP id 406B9303F455
	for <lists+stable@lfdr.de>; Thu, 26 Mar 2026 00:04:56 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 315208460;
	Thu, 26 Mar 2026 00:04:55 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="ZuVQLwUB"
X-Original-To: stable@vger.kernel.org
Received: from mail-pf1-f172.google.com (mail-pf1-f172.google.com [209.85.210.172])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B3347139D
	for <stable@vger.kernel.org>; Thu, 26 Mar 2026 00:04:53 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=pass smtp.client-ip=209.85.210.172
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1774483495; cv=pass; b=DjLOHLgOY7M9kdG/oNbVuVtfIdxjhXGEjC005nO6lC4blQ5FObeBElpnmk1MeLc2ytLx+Z+r49TKsqOlack2UyowcGY1GlRRoScgIu6jvNf486Gm6haO68vQT1t6l5zubZAQ5zvX3ObV65of6y4o/7kQtyebqsObv5KJSMnQknM=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1774483495; c=relaxed/simple;
	bh=x9qQ0TeYjIcWs2kfHvnGXCE79JBLYQrOaPjMrVi+EPE=;
	h=MIME-Version:From:Date:Message-ID:Subject:To:Cc:Content-Type; b=T6ddEHIQQxE1SoiLGXSwKlx7d1b5enYoo2CQmEsukUsxeQHs6kFiIR7zZiuvHvqKXfhoR4QEiRR1mBrzZZ7lpHaz1zDRVhchTnRRUVdQ3zgTGl8Uu/TnsV6Y3LOn+IEhQjiFZ/Ox4T9UfCnhvis+R/6L5EGwDC8W0O40Ghu2Aj0=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=ZuVQLwUB; arc=pass smtp.client-ip=209.85.210.172
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-pf1-f172.google.com with SMTP id d2e1a72fcca58-829b8b6c4d0so369328b3a.0
        for <stable@vger.kernel.org>; Wed, 25 Mar 2026 17:04:53 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; t=1774483493; cv=none;
        d=google.com; s=arc-20240605;
        b=DVSdbuSgFMsCtmi1OMItSRlGIypMfp/ZDhDDjYREviWq7qx2s6q06Boo2nrdmlfxQO
         NPa5TDlhuYi4T32W0HKFwvPEDeU45pcookfXpG7wQluqfjeAKGNG3NaAZaVGkx1l1F5Y
         iZONFlvYhBiA9dAOSwT6C6ADd1SX9po5tqZ0Sw/PE3Elo1lgFiNKsc0ccR+/cOGvcwVX
         XYNP+eval6EP8GoKEp4YBWhL+x0qA09IQDUQqWJEjSPKPOmf02X8VozhLcPLXJR5HEDP
         FuJeP3GNdGmx8ky52Rm5ZeH+jKCVryaQooBtleg8ltReZAfGS+p9/vG995jizMkfI9HY
         81Qg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20240605;
        h=cc:to:subject:message-id:date:from:mime-version:dkim-signature;
        bh=ZAOE78ZtpjWpJhvqZbi0ScYf2zr9vhdXd2hMzVt84ZM=;
        fh=s2YB5zoo5vt3UBrAQUMdc2k40MxmfVnKdJtNek+dPBA=;
        b=TWOEeTLhKsIJs2b/TahmkneuZWlyGegPUUlSR6bpVeJvVYo7YzIpd7KZI/nNeI/VSj
         idVRc3FHTM1/q29uIZRnYczi/4orJRIC/DEbSXUPjOzVPA7gE4KIHl4nX55P9PDt/kJl
         XkadnZKl+MiED2StyUCHz9iS2ZARkvW5n4BxwqosIbjWvs8WhtxQG0Kb7jgh8im2Rh2P
         R2Bd3TBJs4zG7zSt9wR1V1TsQXb+jTeE2dX3a59Z4vPWh7rGwwApTsWjNl3jk+Peegng
         cw87CwATG6ZM5AvqwwcuiLcH06CLTS5Km/1IbdLNoFM0E0TFKX1EdwA4Q3iG53nsEWlF
         AJgQ==;
        darn=vger.kernel.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1774483493; x=1775088293; darn=vger.kernel.org;
        h=cc:to:subject:message-id:date:from:mime-version:from:to:cc:subject
         :date:message-id:reply-to;
        bh=ZAOE78ZtpjWpJhvqZbi0ScYf2zr9vhdXd2hMzVt84ZM=;
        b=ZuVQLwUB1Iq1liBq6fH/jlZoFdxpbzAtW/UYi6OfumSXVrK+CW42hUA0s/wrn3Tdtu
         N4TMQe2jt/bDtvDlYI3AGqjelQ4aFQPKRaTr6VD3GO0ApafE3fCTt9HumvocntQXQoOk
         36iCuc3UFt9APlILnQbzjvFPmV3GbPTGnjFgROFTJ6mhCriIpkj0Hj7XuqQ2WctTpG2V
         PixfcXGYibUZ0df3dOc8uLfXoHM9ah8nGfxOObm/8pNKOO6a3EJtE9mcqYWSbZ98S+R1
         qGvbU5ccAx/1IRBbZ+AdKbNmqAV4q39DY5LE8mytw1HnCr2HmyUlpDSmpfWYrKNd0ezL
         LU6g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1774483493; x=1775088293;
        h=cc:to:subject:message-id:date:from:mime-version:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=ZAOE78ZtpjWpJhvqZbi0ScYf2zr9vhdXd2hMzVt84ZM=;
        b=mfM8PudTgxV1gJZu9sWSODRowmgCuIQZqk/sfUZF474XXsNmuA7TK8WWOJMJPVPVvN
         vGeUrn+/1kGLLedKAoM2x/rALCaD/aEj2/tG5c295HaqsYRmeBlRzuq486jUgKSGp700
         OLJPkmeo8pYoBuwmLHfCJftCaAaA9s/7jeEBaEVssehTP3hOMNFCo2OgwYE+Qf8qKGtE
         OQYvaqyywD8cZ5mtU95s1bc5RGxu+Mw2oeIURMeUpLXsbVqxAK2t3jD/n2cCqUXLHjwn
         eq0iCJgVPOXiWVgdfeDpN/lC63eBILK5xxhwJAl5h5X8e8uVDgndBCVN1rTLsyNwd8w1
         ToVg==
X-Forwarded-Encrypted: i=1; AJvYcCUq87+yYcCYKkIamhKQEPuKhqc9SyhsuaBKrvFwWaiWJdcf82hGcpvrgN8XXx3TJ8R70InG65M=@vger.kernel.org
X-Gm-Message-State: AOJu0YxxuJW3r7qZeHHyPmcyKXi2mt8Xn6zDN/Sru6HF0/CKRqSbBoCM
	SaCJod2JS2nfy77Ri6rk++95cJ5NPsvgdJt2/ZIS/+d6gZi5bRJ6HH8Jt51VNI6ZzSb5V9WM+hL
	yCFqIkSwUUYXXZCV381XwyedxAO29alY=
X-Gm-Gg: ATEYQzz+quPBV7PWs8kkw+XDotaBjgBQCa2N2x4oJYKhZDV434VHk65afXFNqhvxVU3
	A0TVwcjuTkm2VQWi6sbKAFuz+PO5RAzGZV22CpWlmXAjjUwJcg6pEhVYF1sZ1wuqWXJX/TOKRRe
	FAmQe/XbDpj6NhcfSuNaUXULFmihnZAPwulmHgAZl87yYmgK5+enF8B8rYO/sEG1L/mxQ0Z7s4u
	C7G6o5x8tL1IbhvvfAxUCICmqxnkRoMTynYPIrq9oPIhcrrXYuvFDuKv2hdkh71dtl7WwLUZ8OP
	uP6HCUTHRQ==
X-Received: by 2002:a05:6a20:7d86:b0:366:2447:6778 with SMTP id
 adf61e73a8af0-39c4ade3a5amr5485396637.53.1774483492968; Wed, 25 Mar 2026
 17:04:52 -0700 (PDT)
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
From: =?UTF-8?B?7ZmN6ri464+Z?= <jeon1691951@gmail.com>
Date: Thu, 26 Mar 2026 09:04:41 +0900
X-Gm-Features: AaiRm51vJkmkBWvHjshPyhGq0lLbHncMpH613Mx09r3LkXLF5oi5WwuBjbGctQY
Message-ID: <CAB29vr=U=SaQR9m_O_cZwEKAG2LTnbYGjE+uT0snUT7Jco_3bQ@mail.gmail.com>
Subject: [PATCH] KVM: nSVM: Snapshot vmcb12 save.rip to prevent TOCTOU race
To: kvm@vger.kernel.org
Cc: seanjc@google.com, pbonzini@redhat.com, gregkh@linuxfoundation.org, 
	yosryahmed@google.com, linux-kernel@vger.kernel.org, stable@vger.kernel.org
Content-Type: multipart/mixed; boundary="000000000000423b28064de222d7"
X-Spamd-Result: default: False [-2.16 / 15.00];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=2];
	DMARC_POLICY_ALLOW(-0.50)[gmail.com,none];
	R_SPF_ALLOW(-0.20)[+ip4:172.105.105.114:c];
	R_DKIM_ALLOW(-0.20)[gmail.com:s=20251104];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[multipart/mixed,multipart/alternative,text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	DKIM_TRACE(0.00)[gmail.com:+];
	TAGGED_FROM(0.00)[bounces-230395-lists,stable=lfdr.de];
	FROM_HAS_DN(0.00)[];
	HAS_ATTACHMENT(0.00)[];
	MIME_TRACE(0.00)[0:+,1:+,2:+,3:~,4:~];
	RCVD_TLS_LAST(0.00)[];
	FORGED_SENDER_MAILLIST(0.00)[];
	RCVD_COUNT_THREE(0.00)[4];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	ASN(0.00)[asn:63949, ipnet:172.105.96.0/20, country:SG];
	FREEMAIL_FROM(0.00)[gmail.com];
	TO_DN_NONE(0.00)[];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[jeon1691951@gmail.com,stable@vger.kernel.org];
	MISSING_XM_UA(0.00)[];
	NEURAL_HAM(-0.00)[-1.000];
	RCPT_COUNT_SEVEN(0.00)[7];
	MID_RHS_MATCH_FROMTLD(0.00)[];
	TAGGED_RCPT(0.00)[stable];
	DBL_BLOCKED_OPENRESOLVER(0.00)[mail.gmail.com:mid,tor.lore.kernel.org:helo,tor.lore.kernel.org:rdns]
X-Rspamd-Queue-Id: 7E90032D871
X-Rspamd-Action: no action
X-Rspamd-Server: lfdr

--000000000000423b28064de222d7
Content-Type: multipart/alternative; boundary="000000000000423b27064de222d5"

--000000000000423b27064de222d5
Content-Type: text/plain; charset="UTF-8"

Hi all,

Following Greg's suggestion to turn the proposed fix into a real patch,
here is a minimal fix for the vmcb12->save.rip TOCTOU race in KVM's
nested SVM implementation.

Background
----------

The CVE-2021-29657 fix introduced nested_copy_vmcb_save_to_cache() to
snapshot vmcb12 fields before validation and use, preventing a racing L1
vCPU from modifying vmcb12 between check and use. However, the save area
cache deliberately excluded rip, rsp, and rax -- only efer, cr0, cr3,
cr4, dr6, and dr7 are snapshotted.

As a result, vmcb12->save.rip is still read three separate times from
the live guest-mapped HVA pointer during a single nested VMRUN:

  1) enter_svm_guest_mode() passes vmcb12->save.rip to
     nested_vmcb02_prepare_control(), where it is stored in
     svm->soft_int_old_rip, svm->soft_int_next_rip, and
     vmcb02->control.next_rip

  2) nested_vmcb02_prepare_save() calls
     kvm_rip_write(vcpu, vmcb12->save.rip), setting the KVM-internal
     vCPU register state

  3) nested_vmcb02_prepare_save() then does
     vmcb02->save.rip = vmcb12->save.rip, setting the hardware VMCB02
     save area

Since vmcb12 is mapped via kvm_vcpu_map() as a direct HVA into guest
physical memory with no write protection, a concurrent L1 vCPU can
modify vmcb12->save.rip between these reads, producing a three-way RIP
inconsistency. This is the save-area analog of CVE-2021-29657.

The inconsistency is particularly dangerous when combined with soft
interrupt injection (event_inj with TYPE_SOFT): KVM records
soft_int_old_rip from read #1 but the vCPU state and hardware VMCB
reflect reads #2 and #3 respectively. If interrupt delivery faults,
svm_complete_interrupts() uses the stale soft_int_old_rip to
reconstruct pre-injection state, which no longer matches reality.

I am aware of Yosry Ahmed's larger patch series (v3-v6) that
reworks the entire vmcb12 caching architecture and would subsume
this fix. However, that series is still under review and has not
yet been merged. This patch is a minimal, self-contained fix that
can be applied immediately to close the TOCTOU window on rip, rsp,
and rax.

Fix
---

Add rip, rsp, and rax to struct vmcb_save_area_cached, snapshot them
in __nested_copy_vmcb_save_to_cache(), and replace all direct reads
of vmcb12->save.{rip,rsp,rax} with reads from the cached copy. This
ensures all consumers within a single nested VMRUN see consistent
register values.

Testing
-------

Tested on AMD Ryzen 7 7800X3D with nested virtualization enabled
(kvm_amd nested=1). A userspace race harness demonstrated a 25.6%
hit rate for concurrent modification of the rip field between reads
across 1M iterations, with 3-way splits (all three reads returning
different values) confirmed. With the patch applied, all three
consumption points see the same snapshotted value regardless of
concurrent modification.

The original discussion that led to this patch inadvertently went to
a public list. KVM maintainers were not CC'd on the follow-up; this
submission corrects that.

Seungil Jeon (1):
  KVM: nSVM: Snapshot vmcb12 save.rip to prevent TOCTOU race

 arch/x86/kvm/svm/nested.c | 22 +++++++++++-----------
 arch/x86/kvm/svm/svm.h    |  3 +++
 2 files changed, 14 insertions(+), 11 deletions(-)

--
2.43.0

--000000000000423b27064de222d5
Content-Type: text/html; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

<div dir=3D"ltr">Hi all,<br><br>Following Greg&#39;s suggestion to turn the=
 proposed fix into a real patch,<br>here is a minimal fix for the vmcb12-&g=
t;save.rip TOCTOU race in KVM&#39;s<br>nested SVM implementation.<br><br>Ba=
ckground<br>----------<br><br>The CVE-2021-29657 fix introduced nested_copy=
_vmcb_save_to_cache() to<br>snapshot vmcb12 fields before validation and us=
e, preventing a racing L1<br>vCPU from modifying vmcb12 between check and u=
se. However, the save area<br>cache deliberately excluded rip, rsp, and rax=
 -- only efer, cr0, cr3,<br>cr4, dr6, and dr7 are snapshotted.<br><br>As a =
result, vmcb12-&gt;save.rip is still read three separate times from<br>the =
live guest-mapped HVA pointer during a single nested VMRUN:<br><br>=C2=A0 1=
) enter_svm_guest_mode() passes vmcb12-&gt;save.rip to<br>=C2=A0 =C2=A0 =C2=
=A0nested_vmcb02_prepare_control(), where it is stored in<br>=C2=A0 =C2=A0 =
=C2=A0svm-&gt;soft_int_old_rip, svm-&gt;soft_int_next_rip, and<br>=C2=A0 =
=C2=A0 =C2=A0vmcb02-&gt;control.next_rip<br><br>=C2=A0 2) nested_vmcb02_pre=
pare_save() calls<br>=C2=A0 =C2=A0 =C2=A0kvm_rip_write(vcpu, vmcb12-&gt;sav=
e.rip), setting the KVM-internal<br>=C2=A0 =C2=A0 =C2=A0vCPU register state=
<br><br>=C2=A0 3) nested_vmcb02_prepare_save() then does<br>=C2=A0 =C2=A0 =
=C2=A0vmcb02-&gt;save.rip =3D vmcb12-&gt;save.rip, setting the hardware VMC=
B02<br>=C2=A0 =C2=A0 =C2=A0save area<br><br>Since vmcb12 is mapped via kvm_=
vcpu_map() as a direct HVA into guest<br>physical memory with no write prot=
ection, a concurrent L1 vCPU can<br>modify vmcb12-&gt;save.rip between thes=
e reads, producing a three-way RIP<br>inconsistency. This is the save-area =
analog of CVE-2021-29657.<br><br>The inconsistency is particularly dangerou=
s when combined with soft<br>interrupt injection (event_inj with TYPE_SOFT)=
: KVM records<br>soft_int_old_rip from read #1 but the vCPU state and hardw=
are VMCB<br>reflect reads #2 and #3 respectively. If interrupt delivery fau=
lts,<br>svm_complete_interrupts() uses the stale soft_int_old_rip to<br>rec=
onstruct pre-injection state, which no longer matches reality.<br><br>I am =
aware of Yosry Ahmed&#39;s larger patch series (v3-v6) that<br>reworks the =
entire vmcb12 caching architecture and would subsume<br>this fix. However, =
that series is still under review and has not<br>yet been merged. This patc=
h is a minimal, self-contained fix that<br>can be applied immediately to cl=
ose the TOCTOU window on rip, rsp,<br>and rax.<br><br>Fix<br>---<br><br>Add=
 rip, rsp, and rax to struct vmcb_save_area_cached, snapshot them<br>in __n=
ested_copy_vmcb_save_to_cache(), and replace all direct reads<br>of vmcb12-=
&gt;save.{rip,rsp,rax} with reads from the cached copy. This<br>ensures all=
 consumers within a single nested VMRUN see consistent<br>register values.<=
br><br>Testing<br>-------<br><br>Tested on AMD Ryzen 7 7800X3D with nested =
virtualization enabled<br>(kvm_amd nested=3D1). A userspace race harness de=
monstrated a 25.6%<br>hit rate for concurrent modification of the rip field=
 between reads<br>across 1M iterations, with 3-way splits (all three reads =
returning<br>different values) confirmed. With the patch applied, all three=
<br>consumption points see the same snapshotted value regardless of<br>conc=
urrent modification.<br><br>The original discussion that led to this patch =
inadvertently went to<br>a public list. KVM maintainers were not CC&#39;d o=
n the follow-up; this<br>submission corrects that.<br><br>Seungil Jeon (1):=
<br>=C2=A0 KVM: nSVM: Snapshot vmcb12 save.rip to prevent TOCTOU race<br><b=
r>=C2=A0arch/x86/kvm/svm/nested.c | 22 +++++++++++-----------<br>=C2=A0arch=
/x86/kvm/svm/svm.h =C2=A0 =C2=A0| =C2=A03 +++<br>=C2=A02 files changed, 14 =
insertions(+), 11 deletions(-)<br><br>--<br>2.43.0<br></div>

--000000000000423b27064de222d5--
--000000000000423b28064de222d7
Content-Type: application/octet-stream; 
	name="0001-KVM-nSVM-fix-vmcb12-save-rip-TOCTOU.patch"
Content-Disposition: attachment; 
	filename="0001-KVM-nSVM-fix-vmcb12-save-rip-TOCTOU.patch"
Content-Transfer-Encoding: base64
Content-ID: <f_mn6pn0s40>
X-Attachment-Id: f_mn6pn0s40

RnJvbSAwMDAwMDAwMDAwMDAwMDAwMDAwMDAwMDAwMDAwMDAwMDAwMDAwMDAwIE1vbiBTZXAgMTcg
MDA6MDA6MDAgMjAwMQpGcm9tOiBTZXVuZ2lsIEplb24gPGplb24xNjkxOTUxQGdtYWlsLmNvbT4K
RGF0ZTogV2VkLCAyNiBNYXIgMjAyNiAwMDowMDowMCArMDAwMApTdWJqZWN0OiBbUEFUQ0hdIEtW
TTogblNWTTogU25hcHNob3Qgdm1jYjEyIHNhdmUucmlwIHRvIHByZXZlbnQgVE9DVE9VIHJhY2UK
CnZtY2IxMi0+c2F2ZS5yaXAgaXMgcmVhZCB0aHJlZSBzZXBhcmF0ZSB0aW1lcyBmcm9tIGd1ZXN0
LXdyaXRhYmxlIG1lbW9yeQpkdXJpbmcgbmVzdGVkIFZNUlVOIHByb2Nlc3NpbmcsIHdpdGhvdXQg
YmVpbmcgc25hcHNob3R0ZWQgaW50byB0aGUgc2F2ZQphcmVhIGNhY2hlLiBBIG1hbGljaW91cyBM
MSBndWVzdCB3aXRoIG11bHRpcGxlIHZDUFVzIGNhbiBjb25jdXJyZW50bHkKbW9kaWZ5IHZtY2Ix
Mi0+c2F2ZS5yaXAgdGhyb3VnaCBhbm90aGVyIHZDUFUgKHNpbmNlIHRoZSB2bWNiMTIgcGFnZSBp
cwptYXBwZWQgYXMgYSBkaXJlY3QgSFZBIGludG8gZ3Vlc3QgcGh5c2ljYWwgbWVtb3J5IHdpdGgg
bm8gd3JpdGUKcHJvdGVjdGlvbiksIHByb2R1Y2luZyBhIHRocmVlLXdheSBSSVAgaW5jb25zaXN0
ZW5jeSBhY3Jvc3M6CgogIDEpIHN2bS0+c29mdF9pbnRfb2xkX3JpcCBhbmQgc3ZtLT5zb2Z0X2lu
dF9uZXh0X3JpcCAoc2V0IGluCiAgICAgbmVzdGVkX3ZtY2IwMl9wcmVwYXJlX2NvbnRyb2woKSBm
cm9tIHZtY2IxMi0+c2F2ZS5yaXApCiAgMikgdmNwdS0+YXJjaC5yZWdzW1ZDUFVfUkVHU19SSVBd
IChzZXQgdmlhIGt2bV9yaXBfd3JpdGUoKSBpbgogICAgIG5lc3RlZF92bWNiMDJfcHJlcGFyZV9z
YXZlKCkpCiAgMykgdm1jYjAyLT5zYXZlLnJpcCAoc2V0IGRpcmVjdGx5IGluIG5lc3RlZF92bWNi
MDJfcHJlcGFyZV9zYXZlKCkpCgpUaGlzIGlzIHRoZSBzYXZlLWFyZWEgYW5hbG9nIG9mIENWRS0y
MDIxLTI5NjU3LCB3aGljaCBleHBsb2l0ZWQgdGhlCnNhbWUgVE9DVE9VIHBhdHRlcm4gb24gdm1j
YjEyLT5jb250cm9sLmludGVyY2VwdCB0byBhY2hpZXZlIGZ1bGwgaG9zdApjb2RlIGV4ZWN1dGlv
bi4gVGhlIENWRS0yMDIxLTI5NjU3IGZpeCBpbnRyb2R1Y2VkCm5lc3RlZF9jb3B5X3ZtY2Jfc2F2
ZV90b19jYWNoZSgpIGJ1dCBkZWxpYmVyYXRlbHkgZXhjbHVkZWQgcmlwLCByc3AsCmFuZCByYXgg
ZnJvbSB0aGUgY2FjaGVkIGZpZWxkcywgbGVhdmluZyB0aGUgc2F2ZSBhcmVhIHZ1bG5lcmFibGUg
dG8KdGhlIHNhbWUgY2xhc3Mgb2YgY29uY3VycmVudC1tb2RpZmljYXRpb24gYXR0YWNrcy4KCldo
ZW4gY29tYmluZWQgd2l0aCBzb2Z0IGludGVycnVwdCBpbmplY3Rpb24gdmlhIGV2ZW50X2luaiwg
dGhlIHRocmVlLXdheQpSSVAgc3BsaXQgY2F1c2VzIEtWTSB0byByZWNvcmQgaW5jb25zaXN0ZW50
IHN0YXRlIGZvciBpbnRlcnJ1cHQKcmUtaW5qZWN0aW9uOiBzb2Z0X2ludF9vbGRfcmlwIGhvbGRz
IG9uZSB2YWx1ZSAoZnJvbSByZWFkICMxKSwgdGhlIHZDUFUKcmVnaXN0ZXIgc3RhdGUgaG9sZHMg
YW5vdGhlciAoZnJvbSByZWFkICMyKSwgYW5kIHRoZSBoYXJkd2FyZSBWTUNCIGhvbGRzCmEgdGhp
cmQgKGZyb20gcmVhZCAjMykuIElmIGRlbGl2ZXJ5IG9mIHRoZSBzb2Z0IGludGVycnVwdCBmYXVs
dHMgKGUuZy4sCiNQRiBvbiBJRFQgYWNjZXNzKSwgc3ZtX2NvbXBsZXRlX2ludGVycnVwdHMoKSB1
c2VzIHNvZnRfaW50X29sZF9yaXAgdG8KcmVjb25zdHJ1Y3QgdGhlIHByZS1pbmplY3Rpb24gc3Rh
dGUsIHdoaWNoIG5vIGxvbmdlciBtYXRjaGVzIHRoZSBhY3R1YWwKdkNQVSBvciBoYXJkd2FyZSBz
dGF0ZS4gVGhpcyBjYW4gdHJpZ2dlciBXQVJOX09OIGFzc2VydGlvbnMgaW4gS1ZNJ3MKaW50ZXJy
dXB0IGhhbmRsaW5nLCBjYXVzZSBpbnN0cnVjdGlvbiBlbXVsYXRpb24gYXQgd3JvbmcgYWRkcmVz
c2VzLCBvcgpsZWFkIHRvIGluZm9ybWF0aW9uIGRpc2Nsb3N1cmUgdGhyb3VnaCBjb25mdXNlZCBl
bXVsYXRpb24uCgpGaXggdGhpcyBieSBhZGRpbmcgcmlwLCByc3AsIGFuZCByYXggdG8gdm1jYl9z
YXZlX2FyZWFfY2FjaGVkLCBjb3B5aW5nCnRoZW0gaW4gX19uZXN0ZWRfY29weV92bWNiX3NhdmVf
dG9fY2FjaGUoKSwgYW5kIHJlcGxhY2luZyBhbGwgZGlyZWN0CnJlYWRzIG9mIHZtY2IxMi0+c2F2
ZS57cmlwLHJzcCxyYXh9IHdpdGggcmVhZHMgZnJvbSB0aGUgY2FjaGVkIGNvcHkuClRoaXMgZW5z
dXJlcyB0aGF0IGFsbCBjb25zdW1lcnMgd2l0aGluIGEgc2luZ2xlIG5lc3RlZCBWTVJVTiBzZWUg
YQpjb25zaXN0ZW50IHNuYXBzaG90IG9mIHRoZXNlIHJlZ2lzdGVycywgY2xvc2luZyB0aGUgVE9D
VE9VIHdpbmRvdy4KClRoZSBzYW1lIGFwcHJvYWNoIGlzIHVzZWQgZm9yIHJzcCBhbmQgcmF4LCB3
aGljaCBzdWZmZXIgZnJvbSBhbmFsb2dvdXMKKHRob3VnaCBjdXJyZW50bHkgdHdvLXJlYWQgcmF0
aGVyIHRoYW4gdGhyZWUtcmVhZCkgVE9DVE9VIHBhdHRlcm5zIGluCm5lc3RlZF92bWNiMDJfcHJl
cGFyZV9zYXZlKCkuCgpDYzogc3RhYmxlQHZnZXIua2VybmVsLm9yZwpSZXBvcnRlZC1ieTogU2V1
bmdpbCBKZW9uIDxqZW9uMTY5MTk1MUBnbWFpbC5jb20+ClNpZ25lZC1vZmYtYnk6IFNldW5naWwg
SmVvbiA8amVvbjE2OTE5NTFAZ21haWwuY29tPgotLS0KIGFyY2gveDg2L2t2bS9zdm0vbmVzdGVk
LmMgfCAyMiArKysrKysrKysrKy0tLS0tLS0tLS0tCiBhcmNoL3g4Ni9rdm0vc3ZtL3N2bS5oICAg
IHwgIDMgKysrCiAyIGZpbGVzIGNoYW5nZWQsIDE0IGluc2VydGlvbnMoKyksIDExIGRlbGV0aW9u
cygtKQoKZGlmZiAtLWdpdCBhL2FyY2gveDg2L2t2bS9zdm0vc3ZtLmggYi9hcmNoL3g4Ni9rdm0v
c3ZtL3N2bS5oCmluZGV4IFhYWFhYWFguLlhYWFhYWFggMTAwNjQ0Ci0tLSBhL2FyY2gveDg2L2t2
bS9zdm0vc3ZtLmgKKysrIGIvYXJjaC94ODYva3ZtL3N2bS9zdm0uaApAQCAtWFhYLFhYICtYWFgs
WFggQEAgc3RydWN0IHZtY2Jfc2F2ZV9hcmVhX2NhY2hlZCB7CiAJdTY0IGNyNDsKIAl1NjQgZHI2
OwogCXU2NCBkcjc7CisJdTY0IHJpcDsKKwl1NjQgcnNwOworCXU2NCByYXg7CiB9OwoKIHN0cnVj
dCB2bWNiX2N0cmxfYXJlYV9jYWNoZWQgewpkaWZmIC0tZ2l0IGEvYXJjaC94ODYva3ZtL3N2bS9u
ZXN0ZWQuYyBiL2FyY2gveDg2L2t2bS9zdm0vbmVzdGVkLmMKaW5kZXggWFhYWFhYWC4uWFhYWFhY
WCAxMDA2NDQKLS0tIGEvYXJjaC94ODYva3ZtL3N2bS9uZXN0ZWQuYworKysgYi9hcmNoL3g4Ni9r
dm0vc3ZtL25lc3RlZC5jCkBAIC1YWFgsWFggK1hYWCxYWCBAQCBzdGF0aWMgdm9pZCBfX25lc3Rl
ZF9jb3B5X3ZtY2Jfc2F2ZV90b19jYWNoZShzdHJ1Y3Qgdm1jYl9zYXZlX2FyZWFfY2FjaGVkICp0
bywKIAkJCQkJICAgICAgc3RydWN0IHZtY2Jfc2F2ZV9hcmVhICpmcm9tKQogewogCS8qCi0JICog
Q29weSBvbmx5IGZpZWxkcyB0aGF0IGFyZSB2YWxpZGF0ZWQsIGFzIHdlIG5lZWQgdGhlbQotCSAq
IHRvIGF2b2lkIFRPQy9UT1UgcmFjZXMuCisJICogQ29weSBmaWVsZHMgdGhhdCBhcmUgZWl0aGVy
IHZhbGlkYXRlZCBvciByZWFkIG11bHRpcGxlIHRpbWVzLAorCSAqIGFzIHdlIG5lZWQgYSBjb25z
aXN0ZW50IHNuYXBzaG90IHRvIGF2b2lkIFRPQy9UT1UgcmFjZXMuCisJICogcmlwL3JzcC9yYXgg
YXJlIHJlYWQgbXVsdGlwbGUgdGltZXMgZnJvbSBndWVzdC13cml0YWJsZQorCSAqIG1lbW9yeSBp
biBlbnRlcl9zdm1fZ3Vlc3RfbW9kZSgpIGFuZCBtdXN0IGJlIHNuYXBzaG90dGVkLgogCSAqLwog
CXRvLT5lZmVyID0gZnJvbS0+ZWZlcjsKIAl0by0+Y3IwICA9IGZyb20tPmNyMDsKIAl0by0+Y3Iz
ICA9IGZyb20tPmNyMzsKIAl0by0+Y3I0ICA9IGZyb20tPmNyNDsKIAl0by0+ZHI2ICA9IGZyb20t
PmRyNjsKIAl0by0+ZHI3ICA9IGZyb20tPmRyNzsKKwl0by0+cmlwICA9IGZyb20tPnJpcDsKKwl0
by0+cnNwICA9IGZyb20tPnJzcDsKKwl0by0+cmF4ICA9IGZyb20tPnJheDsKIH0KCiAvKgpAQCAt
WFhYLFhYICtYWFgsWFggQEAgc3RhdGljIHZvaWQgbmVzdGVkX3ZtY2IwMl9wcmVwYXJlX3NhdmUo
c3RydWN0IHZjcHVfc3ZtICpzdm0sCiAJCQkJCXN0cnVjdCB2bWNiICp2bWNiMTIpCiB7CisJc3Ry
dWN0IHZtY2Jfc2F2ZV9hcmVhX2NhY2hlZCAqc2F2ZSA9ICZzdm0tPm5lc3RlZC5zYXZlOwogCXN0
cnVjdCBrdm1fdmNwdSAqdmNwdSA9ICZzdm0tPnZjcHU7CgogCS8qIC4uLiBzZWdtZW50IHJlZ2lz
dGVyIGNvcGllcyBmcm9tIHZtY2IxMiAodW5jaGFuZ2VkKSAuLi4gKi8KCi0Ja3ZtX3JpcF93cml0
ZSh2Y3B1LCB2bWNiMTItPnNhdmUucmlwKTsKLQl2bWNiMDItPnNhdmUucmlwID0gdm1jYjEyLT5z
YXZlLnJpcDsKKwlrdm1fcmlwX3dyaXRlKHZjcHUsIHNhdmUtPnJpcCk7CisJdm1jYjAyLT5zYXZl
LnJpcCA9IHNhdmUtPnJpcDsKCi0Ja3ZtX3JzcF93cml0ZSh2Y3B1LCB2bWNiMTItPnNhdmUucnNw
KTsKLQl2bWNiMDItPnNhdmUucnNwID0gdm1jYjEyLT5zYXZlLnJzcDsKKwlrdm1fcnNwX3dyaXRl
KHZjcHUsIHNhdmUtPnJzcCk7CisJdm1jYjAyLT5zYXZlLnJzcCA9IHNhdmUtPnJzcDsKCi0Ja3Zt
X3JheF93cml0ZSh2Y3B1LCB2bWNiMTItPnNhdmUucmF4KTsKLQl2bWNiMDItPnNhdmUucmF4ID0g
dm1jYjEyLT5zYXZlLnJheDsKKwlrdm1fcmF4X3dyaXRlKHZjcHUsIHNhdmUtPnJheCk7CisJdm1j
YjAyLT5zYXZlLnJheCA9IHNhdmUtPnJheDsKCiAJLyogLi4uIHJlbWFpbmRlciBvZiBmdW5jdGlv
biB1bmNoYW5nZWQgLi4uICovCiB9CkBAIC1YWFgsWFggK1hYWCxYWCBAQCBpbnQgZW50ZXJfc3Zt
X2d1ZXN0X21vZGUoc3RydWN0IHZjcHVfc3ZtICpzdm0sCiAJCQkgc3RydWN0IHZtY2IgKnZtY2Ix
MiwgYm9vbCBmcm9tX3ZtcnVuKQogeworCXN0cnVjdCB2bWNiX3NhdmVfYXJlYV9jYWNoZWQgKnNh
dmUgPSAmc3ZtLT5uZXN0ZWQuc2F2ZTsKIAlzdHJ1Y3Qgdm1jYiAqdm1jYjAyID0gc3ZtLT5uZXN0
ZWQudm1jYjAyLnB0cjsKCiAJLyogLi4uIGV4aXN0aW5nIGNvZGUgLi4uICovCgotCW5lc3RlZF92
bWNiMDJfcHJlcGFyZV9jb250cm9sKHN2bSwgdm1jYjEyLT5zYXZlLnJpcCwKLQkJCQkgICAgICB2
bWNiMTItPnNhdmUuY3MuYmFzZSk7CisJbmVzdGVkX3ZtY2IwMl9wcmVwYXJlX2NvbnRyb2woc3Zt
LCBzYXZlLT5yaXAsCisJCQkJICAgICAgdm1jYjEyLT5zYXZlLmNzLmJhc2UpOwoKIAluZXN0ZWRf
dm1jYjAyX3ByZXBhcmVfc2F2ZShzdm0sIHZtY2IxMik7CgogCS8qIC4uLiByZW1haW5kZXIgb2Yg
ZnVuY3Rpb24gdW5jaGFuZ2VkIC4uLiAqLwogfQotLQoyLjQzLjAK
--000000000000423b28064de222d7--

